//
//  MessageListViewController.swift
//  Goji
//
//  Created by Eric Andersen on 10/11/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class MessageListViewController: UIViewController {
    
    private let cellId = MessageListCell.reuseIdentifier
    var dataSource = MockConversation.currentConversations
    
    let searchUserController = MessageSearchUserViewController()
    var searchController: UISearchController?
    
    @IBOutlet weak var messageTitleLabel: UILabel!
    @IBOutlet weak var messageListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageListTableView.dataSource = self
        messageListTableView.delegate = self
        
        updateView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource = MockConversation.currentConversations
        messageListTableView.reloadData()
        deselectCell()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationItem.searchController?.isActive = false
        
    }
    
    @IBAction func newMessageButtonTapped(_ sender: UIBarButtonItem) {
        searchController?.searchBar.becomeFirstResponder()
    }
}

// MARK: - Setup UI
private extension MessageListViewController {
    func updateView() {
        setupSearchController()
        setupNavigationBar()
    }
    
    func deselectCell() {
        if let index = self.messageListTableView.indexPathForSelectedRow{
            self.messageListTableView.deselectRow(at: index, animated: true)
        }
    }
    
    func setupNavigationBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: searchUserController)
        searchController?.searchResultsUpdater = self
        searchController?.searchBar.becomeFirstResponder()
        definesPresentationContext = true
    }
}

// MARK: - UITableViewDataSouce
extension MessageListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MessageListCell
            else { return UITableViewCell() }
        
        let mockConversation = dataSource[indexPath.row]
        
        let recentMessage = mockConversation.last!
        
        let chatPartner = recentMessage.receiver != MockDataUsers.sam ? recentMessage.receiver : recentMessage.sentFrom
        let conversation = Conversation.init(chatPartner: chatPartner, mostRecentMessage: recentMessage)
        cell.conversation = conversation
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MessageListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mockConversation = dataSource[indexPath.row]
        
        let sentFrom = mockConversation[0].sentFrom
        let receiver = mockConversation[0].receiver
        
        let chatPartner = receiver != MockDataUsers.sam ? receiver : sentFrom
        
        let chatViewController = ChatViewController(
            currentUser: MockDataUsers.sam, chatPartner: chatPartner, messages: mockConversation)
        
        
        navigationController?.pushViewController(chatViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            dataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension MessageListViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if !searchController.isActive {
            return
        }
        
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
        searchUserController.filter(with: searchText)
    }
}

extension MessageListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let searchController = searchController else { return }
        searchController.searchBar.resignFirstResponder()
    }
}


