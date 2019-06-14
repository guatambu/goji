//
//  StorageManager.swift
//  Goji
//
//  Created by Jason Goodney on 10/10/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageManager {
    
    /// Uploads data to Storage at the storage path
    ///
    /// - Parameters:
    ///   - storagePath: The storage path the data will be uploaded to
    ///   - uploadData: The data that will be uploaded
    ///   - completion: Completes with true if the data was uploaded
    func uploadData(toStoragePath storagePath: String, uploadData: Data,
                    completion: @escaping (_ success: Bool) -> Void) {
        
        Endpoint.storageRef.child(storagePath).putData(uploadData, metadata: nil) { (storageMetadata, error) in
            if let error = error {
                print("Error upload data to storage path: \(storagePath) \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
            
            completion(true)
        }
    }
    
    /// Downloads data from Storage at the storage path
    ///
    /// - Parameters:
    ///   - storagePath: The storage path the data will be downloaded from
    ///   - completion: Completes with the download url of the stored item
    func downloadData(atStoragePath storagePath: String,
                      completion: @escaping (_ url: URL?, _ error: Error?) -> Void) {
        
        Endpoint.storageRef.child(storagePath).downloadURL { (downloadUrl, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let url = downloadUrl else {
                completion(nil, error)
                return
            }
            
            completion(url, error)
        }
    }
    
    // Download Image
    func downloadImage(at url: URL, completion: @escaping (UIImage?) -> Void) {
        let ref = Storage.storage().reference(forURL: url.absoluteString)
        let megaByte = Int64(1 * 1024 * 1024)
        
        ref.getData(maxSize: megaByte) { (data, error) in
            guard let imageData = data else { completion(nil); return }
            completion(UIImage(data: imageData))
        }
    }
    
    // Upload Image
    func uploadImage(_ image: UIImage, toStorage storage: StorageReference,
                     completion: @escaping (URL?) -> Void) {
        
        guard let data = image.jpegData(compressionQuality: 0.4) else {
            completion(nil)
            return
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let profileImageStoragePath = storage.child(UUID().uuidString).fullPath
        
        uploadData(toStoragePath: profileImageStoragePath, uploadData: data) { (success) in
            if !success {
                print("Unable to upload image to storage at path: \(profileImageStoragePath)")
            } else {
                storage.child("profileImage").downloadURL(completion: { (url, error) in
                    completion(url)
                })
            }
        }
        
    }
}
