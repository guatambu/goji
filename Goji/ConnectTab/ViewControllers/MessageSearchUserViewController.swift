//
//  MessageSearchUserViewController.swift
//  Goji
//
//  Created by Eric Andersen on 10/11/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class SubtitleTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MessageSearchUserViewController: UIViewController {
    
    // MARK: - Properties
    private let cellId = "connectNewMessageSearchResultsCell"
    
    var currentConversationsDataSource: [User] = Array(MockDataUsers.allOtherUsers[..<MockConversation.currentConversations.count])
    var potentialConversationsDataSource: [User] = Array(MockDataUsers.allOtherUsers[MockConversation.currentConversations.count...])
    
    lazy var filteredCurrentConversationsDataSource: [User] = self.currentConversationsDataSource
    var filteredPotentialConversationsDataSource: [User] = []
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.register(SubtitleTableViewCell.self, forCellReuseIdentifier: cellId)
        return view
    }()
    
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        currentConversationsDataSource = Array(MockDataUsers.allOtherUsers[..<MockConversation.currentConversations.count])
        potentialConversationsDataSource = Array(MockDataUsers.allOtherUsers[MockConversation.currentConversations.count...])
        tableView.reloadData()
    }
    func filter(with searchText: String) {
        if searchText == "" {
            filteredCurrentConversationsDataSource = currentConversationsDataSource
            filteredPotentialConversationsDataSource = []
        } else {
            filteredCurrentConversationsDataSource = filter(currentConversationsDataSource, with: searchText)
            filteredPotentialConversationsDataSource = filter(potentialConversationsDataSource, with: searchText)
        }
        
        tableView.reloadData()
    }
    
    private func filter(_ dataSource: [User], with searchText: String) -> [User] {
        return dataSource.filter({ (user) -> Bool in
            
            return user.username.lowercased().hasPrefix(searchText) ||
                user.fullName.lowercased().hasPrefix(searchText)
        })
    }
}

// MARK: - Setup UI
private extension MessageSearchUserViewController {
    func updateView() {
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
}

// MARK: - UITableViewDataSource
extension MessageSearchUserViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return filteredCurrentConversationsDataSource.count
        case 1:
            return filteredPotentialConversationsDataSource.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SubtitleTableViewCell else { print("could not dequeue cell"); return UITableViewCell() }
        
        var dataSource: [User] = []
        
        if indexPath.section == 0 {
            dataSource = filteredCurrentConversationsDataSource
        } else if indexPath.section == 1 {
            dataSource = filteredPotentialConversationsDataSource
        }
        
        let user = dataSource[indexPath.row]
        
        cell.textLabel?.text = user.username
        cell.detailTextLabel?.text = user.fullName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0 where filteredCurrentConversationsDataSource.count > 0:
            return "Current Connections"
        case 1 where filteredPotentialConversationsDataSource.count > 0:
            return "Connect With"
        default:
            return ""
        }
    }
}

// MARK: - UITableViewDelegate
extension MessageSearchUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var dataSource: [User] = []
        var chatViewController: ChatViewController?
        
        if indexPath.section == 0 {
            dataSource = filteredCurrentConversationsDataSource
        } else if indexPath.section == 1 {
            dataSource = filteredPotentialConversationsDataSource
        }
        
        let chatPartner = dataSource[indexPath.row]
        
        //        if indexPath.section == 1 {
        //            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        //            if let indexPath = tableView.indexPath(for: cell) {
        //                let itemToRemove = dataSource[indexPath.row]
        //                filteredPotentialConversationsDataSource.removeAll(where: { $0 == itemToRemove })
        //                filteredCurrentConversationsDataSource.insert(chatPartner, at: 0)
        //            }
        //        }
        
        let currentUser = MockDataUsers.sam
        
        if indexPath.section == 0 {
            guard let messages = MockConversation.allDictionary[chatPartner] else { return }
            chatViewController = ChatViewController(currentUser: currentUser, chatPartner: chatPartner, messages: messages)
        } else if indexPath.section == 1 {
            chatViewController = ChatViewController(currentUser: currentUser, chatPartner: chatPartner, chatType: .new)
        }
        
        let backItem = UIBarButtonItem()
        backItem.title = "Messages"
        navigationItem.backBarButtonItem = backItem
        
        guard let messageListViewController = self.presentingViewController else { return }
        guard let chatVC = chatViewController else { return }
        
        messageListViewController.navigationController?.pushViewController(chatVC, animated: true)
    }
    
}

extension MessageSearchUserViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        if searchText == "" {
            filteredCurrentConversationsDataSource = currentConversationsDataSource
            filteredPotentialConversationsDataSource = []
        } else {
            filteredCurrentConversationsDataSource = filter(currentConversationsDataSource, with: searchText)
            filteredPotentialConversationsDataSource = filter(potentialConversationsDataSource, with: searchText)
        }
        
        tableView.reloadData()
    }
}

