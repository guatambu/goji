//
//  InspirationDetailViewController.swift
//  Goji
//
//  Created by Eric Andersen on 10/11/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class InspirationDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var inspirationDetailView: UIView!
    @IBOutlet weak var detailItemCollectionView: UICollectionView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var sharingButton: UIButton!
    @IBOutlet weak var completedButton: UIButton!
    @IBOutlet weak var sharingTableView: UITableView!
    @IBOutlet weak var adviseTableView: UITableView!
    @IBOutlet weak var quickAddButton: UIButton!
    
    
    // MARK: - Properties
    var bucketListItem: BucketListItem?
    
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailItemCollectionView.delegate = self
        detailItemCollectionView.dataSource = self
        sharingTableView.delegate = self
        sharingTableView.dataSource = self
        adviseTableView.delegate = self
        adviseTableView.dataSource = self
        setUPUI()
        updateView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    // MARK: - Functions
    func setUpNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func setUPUI() {
        title = ""
        itemNameLabel.adjustsFontSizeToFitWidth = true
    }
    
    func updateView() {
        itemNameLabel.text = bucketListItem?.title
    }
    
    func toggleQuickAddButton() {
        quickAddButton.isSelected = !quickAddButton.isSelected
        if quickAddButton.isSelected {
            quickAddButton.setImage(#imageLiteral(resourceName: "myBucketTab"), for: .normal)
            quickAddButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: (quickAddButton.bounds.width - 20))
            quickAddButton.setTitle("Added!", for: .normal)
            quickAddButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: ((quickAddButton.imageView?.frame.width) ?? 0), bottom: 0, right: 0)
            quickAddButton.titleLabel?.textAlignment = .center
            quickAddButton.titleLabel?.adjustsFontSizeToFitWidth = true
            quickAddButton.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            // MyListController.myItems.append(thisItem)
        } else {
            quickAddButton.setImage(nil, for: .normal)
            quickAddButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            quickAddButton.setTitle("Add to List", for: .normal)
            quickAddButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            quickAddButton.titleLabel?.textAlignment = .center
            quickAddButton.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.3607843137, blue: 0.3647058824, alpha: 1)
            // MyListController.myItems.remove(thisItem)
        }
    }
    
    func toggleSharing() {
        sharingTableView.isHidden = !sharingTableView.isHidden
        if !sharingTableView.isHidden {
            sharingButton.backgroundColor = .red
        } else {
            sharingButton.backgroundColor = .clear
        }
    }
    
    
    // MARK: - Actions
    @IBAction func quickAddButtonTapped(_ sender: UIButton) {
        toggleQuickAddButton()
    }
    
    @IBAction func sharingButtonTapped(_ sender: UIButton) {
        toggleSharing()
    }
    
    @IBAction func completedButtonTapped(_ sender: UIButton) {
    }
}


extension InspirationDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bucketListItem?.mockPhoto?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "inspirationItemPhotosCell", for: indexPath) as? InspirationItemDetailPhotosCollectionViewCell
        cell?.itemDetailImageView.image = bucketListItem?.mockPhoto?[indexPath.row]
        
        return cell ?? UICollectionViewCell()
    }
}


extension InspirationDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLayoutSubviews(){
        
        sharingTableView.frame = CGRect(x: sharingTableView.frame.origin.x, y: sharingTableView.frame.origin.y, width: sharingTableView.frame.size.width, height: sharingTableView.contentSize.height)
        sharingTableView.reloadData()
        
        adviseTableView.frame = CGRect(x: adviseTableView.frame.origin.x, y: adviseTableView.frame.origin.y, width: adviseTableView.frame.size.width, height: adviseTableView.contentSize.height)
        
        adviseTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
    //
    //        var count = 0
    //
    //        if tableView == sharingTableView {
    //            count = MockDataUsers.getMockUsers().count
    //        } else if tableView == adviseTableView {
    //            count = bucketListItem?.mockPhoto?.count ?? 0
    //        }
    //
    //        return count
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if tableView == sharingTableView {
            let sharingCell = sharingTableView.dequeueReusableCell(withIdentifier: "inspirationSharingUsersCell")
            let user = MockDataUsers.allOtherUsers[indexPath.row]
            DispatchQueue.main.async {
                sharingCell?.imageView?.image = user.mockProfilePic
            }
            sharingCell?.textLabel?.text = "\(user.firstName!) \(user.lastName!)"
            cell = sharingCell ?? UITableViewCell()
        }
        
        if tableView == adviseTableView {
            let adviseCell = adviseTableView.dequeueReusableCell(withIdentifier: "inspirationAdviceCell")
            let item = bucketListItem!
            DispatchQueue.main.async {
                adviseCell?.imageView?.image = item.user.mockProfilePic
            }
            adviseCell?.textLabel?.text = "@\(item.user.username)"
            adviseCell?.detailTextLabel?.text = item.experienceDescription
            cell = adviseCell ?? UITableViewCell()
        }
        
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
