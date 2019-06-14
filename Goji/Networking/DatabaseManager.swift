//
//  DatabaseManager.swift
//  Goji
//
//  Created by Jason Goodney on 10/10/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import FirebaseFirestore

class DatabaseManager {
    
    // Write
    func setNewUser(document: String, toCollection collection: CollectionReference, data: Dictionary<String, Any>,
                    completion: @escaping (_ success: Bool) -> Void) {
        
        collection.document(document).setData(data) { (error) in
            if let error = error {
                print("Unable to set data to document: \(document) \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func addDocument(toCollection collection: CollectionReference, data: Dictionary<String, Any>,
                     completion: @escaping (_ success: Bool) -> Void) {
        
        // Cloud Firestore creates collections and documents implicitly the first time you add data to the document
        // Documents in a collection can contain different sets of information.
        collection.addDocument(data: data) { (error) in
            if let error = error {
                print("Unable to add data to collection: \(collection.path) \(error) \(error.localizedDescription)")
                completion(false)
                return
            } else {
                print("Document added to the database")
                completion(true)
            }
        }
    }
    func addDocument(toCollectionPath collectionPath: String, data: Dictionary<String, Any>,
                     completion: @escaping (_ success: Bool) -> Void) {
        
        // Cloud Firestore creates collections and documents implicitly the first time you add data to the document
        // Documents in a collection can contain different sets of information.
        Endpoint.database.collection(collectionPath).addDocument(data: data) { (error) in
            if let error = error {
                print("Unable to add data to collection: \(collectionPath) \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
        }
    }
    
    /// Reads all the documents from the Firestore database
    /// at the given collection path
    ///
    /// - Parameters:
    ///   - collectionPath: The collection path: e.g. "users" or "messages"
    ///   - completion: Completes with documents in the collection if documents exist
    func getDocuments(forCollectionPath collectionPath: String, completion: @escaping (_ documents: [QueryDocumentSnapshot]?, _ error: Error?) -> Void) {
        Endpoint.database.collection(collectionPath).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error get the documents at collection path: \(collectionPath) \(error) \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                completion(nil, error)
                return
            }
            
            completion(documents, nil)
        }
    }
    
    /// Gets a specific documents
    ///
    /// - Parameters:
    ///   - collectionPath: The collection path: e.g. "users" or "messages"
    ///   - documentPath: The path to the document
    ///   - completion: Completes with a document if it exists
    func getDocument(forCollectionPath collectionPath: String,
                     documentPath: String,
                     completion: @escaping (_ document: Dictionary<String, Any>?, _ error: Error?) -> Void) {
        
        Endpoint.database.collection(collectionPath).document(documentPath).getDocument { (documentSnapshot, error) in
            if let error = error {
                print("Error get the document at document path: \(documentPath) \(error) \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard let documentSnapshot = documentSnapshot, documentSnapshot.exists else {
                completion(nil, error)
                return
            }
            
            let document = documentSnapshot.data()
            
            completion(document, error)
        }
    }
    
    
    /// Update a document with the given fields
    ///
    /// - Parameters:
    ///   - collectionPath: String path to the collection
    ///   - documentPath: String path to the document
    ///   - fields: Document fields that will be updated
    ///   - completion: Completes with true if the document is updated
    func updateDocument(forCollectionPath collectionPath: String,
                        documentPath: String,
                        withFields fields: Dictionary<String, Any>,
                        completion: @escaping (_ success: Bool) -> Void) {
        
        Endpoint.database.collection(collectionPath).document(documentPath).updateData(fields) { (error) in
            if let error = error {
                print("Error updating document at document path: \(documentPath) \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
            
            completion(true)
        }
    }
}

