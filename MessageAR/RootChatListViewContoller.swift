//
//  RootChatListViewContoller.swift
//  MessageAR
//
//  Created by Admin on 07.04.2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation
import UIKit

class RootChatListViewController: UIViewController {
  @IBOutlet weak var chatListTable: UITableView!
  let spinner = UIActivityIndicatorView(style: .gray)
  
  var modelController: ChatModelController?
  var filteredChatList = [ChatProtocol]()
  let searchController = UISearchController(searchResultsController: nil)
  
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
    fetchChatList()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    chatListTable.reloadData()
  }
  
  func fetchChatList() {
    let http = HttpFetch()
    spinner.startAnimating()
    http.createGetRequest(headers: nil){
      [unowned self](data, response, error) in
      guard let data = data, error == nil else { return }
      do {
        let chatResponseJson = try JSONDecoder().decode(ChatListResponseJson.self, from: data)
        guard let chatList = chatResponseJson.body else {
          return
        }
        DispatchQueue.main.async {
          self.modelController = ChatModelController(chatList: chatList)
          self.chatListTable.reloadData()
          self.spinner.stopAnimating()
          self.spinner.isHidden = true
        }
      } catch let error {
        print(error)
      }
    }
  }
  
  func isSearchBarEmpty() -> Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func isFiltered() -> Bool {
    return searchController.isActive && !isSearchBarEmpty()
  }
  
  func filterChatListForSearch(searchText: String) {
    let chatList =  modelController?.chatList ?? []
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
      return modelController?.chatList?[indexPath.row]
    }
  }
}

extension RootChatListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltered() {
      return filteredChatList.count
    } else {
      return modelController?.chatList?.count ?? 0
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
    if let destination = segue.destination as? ChatViewController,
      let indexPath = sender as? IndexPath,
      let chat = getChat(indexPath: indexPath) {
     destination.modelController = modelController
     destination.chatId = chat.id
    }
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
