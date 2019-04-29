//
//  RootChatListViewContoller.swift
//  MessageAR
//
//  Created by Admin on 07.04.2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation
import UIKit

protocol RootChatListPresentationProtocol {
  var modelController: ChatModelController { get set }
  var chatList: [ChatProtocol] {get}
  var chatCount: Int { get }
  var delegate: RootChatListPresentorDelegate? { get set }
  func viewDidLoadHandler()
  func getChat(by indexPath: IndexPath) -> ChatProtocol
}

class RootChatListViewController: UIViewController, RootChatListPresentorDelegate {
  
  @IBOutlet weak var chatListTable: UITableView!
  let spinner = UIActivityIndicatorView(style: .gray)
  
  var presentor: RootChatListPresentationProtocol?
  
  var filteredChatList = [ChatProtocol]()
  let searchController = UISearchController(searchResultsController: nil)
  let segmentControl = UISegmentedControl(items: ["all", "today"])
  let cellIdentifier = String(describing: RootChatListTableViewCell.self)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Chat"
    
    navigationItem.hidesBackButton = true
    navigationItem.hidesSearchBarWhenScrolling = false
    navigationItem.searchController = searchController
    
    chatListTable.register(
      UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier
    )
    chatListTable.delegate = self
    chatListTable.dataSource = self
    chatListTable.tableFooterView = UIView.init()
    chatListTable.backgroundView = spinner
    chatListTable.tableHeaderView = segmentControl
    
    presentor = RootChatListPresentor()
    presentor?.delegate = self
    presentor?.viewDidLoadHandler()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    chatListTable.reloadData()
  }
  
  func fetchingStart() {
    spinner.startAnimating()
  }
  
  func fetchingEnd() {
    self.spinner.stopAnimating()
    self.spinner.isHidden = true
    self.chatListTable.reloadData()
  }
  
  func isSearchBarEmpty() -> Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func isFiltered() -> Bool {
    return searchController.isActive && !isSearchBarEmpty()
  }
  
  func filterChatListForSearch(searchText: String) {
    let chatList =  presentor?.chatList ?? []
    filteredChatList = chatList.filter{
      (chat: ChatProtocol) -> Bool in
      return chat.title.lowercased().contains(searchText.lowercased())
    }
    chatListTable.reloadData()
  }
  
  func getChat(indexPath: IndexPath) -> ChatProtocol? {
    if isFiltered() {
      return filteredChatList[indexPath.row]
    } else {
      return presentor?.getChat(by: indexPath)
    }
  }
}

extension RootChatListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltered() {
      return filteredChatList.count
    } else {
      return presentor?.chatCount ?? 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let chatCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! RootChatListTableViewCell
    
    if let chat = getChat(indexPath: indexPath) {
       chatCell.setCellValue(chat: chat)
    }
    
    return chatCell
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    cell.backgroundColor = UIColor.clear
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "RootChatListToChatSegue", sender: indexPath)
    searchController.isActive = false
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let destination = segue.destination as? ChatViewController,
      let indexPath = sender as? IndexPath,
      let chat = getChat(indexPath: indexPath),
      let presentor = presentor else {
        return
    }
    destination.presentor = ChatPresentor(chatId: chat.id, modelController: presentor.modelController)
  }
  
  //MARK: - UITableViewDelegate
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60.0
  }
}

extension RootChatListViewController: UISearchResultsUpdating {
  // MARK: - UISearchResultsUpdating Delegate
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text else { return }
    filterChatListForSearch(searchText: searchText)
  }
}
