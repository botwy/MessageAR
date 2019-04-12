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
  var modelController: ChatModelController? = ChatModelController(chatList: createChatList())
  
  let cellIdentifier = String(describing: RootChatListTableViewCell.self)
  
  var chatList: [ChatProtocol] = [] {
    didSet {
      DispatchQueue.main.async {
        self.chatListTable.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    chatListTable.register(
      UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier
    )
    chatListTable.delegate = self
    chatListTable.dataSource = self
    chatListTable.tableFooterView = UIView.init()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    chatListTable.reloadData()
  }
  
  func getChatList() {
    let http = HttpFetch()
    http.createGetRequest { [unowned self](data, response, error) in
      guard let data = data, error == nil else { return }
      do {
        let chatResponseJson = try JSONDecoder().decode(ChatListResponseJson.self, from: data)
        guard let chatList = chatResponseJson.body else { return }
        self.chatList = chatList
      } catch let error {
        print(error)
      }
    }
  }
}

extension RootChatListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return modelController?.chatList?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let chatCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! RootChatListTableViewCell
    
    if let chat = modelController?.chatList?[indexPath.row] {
       chatCell.setCellValue(chat: chat)
    }
    
    return chatCell
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    cell.backgroundColor = UIColor.clear
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "ChatViewController", sender: indexPath)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? ChatViewController,
      let indexPath = sender as? IndexPath {
     destination.modelController = modelController
     destination.chatId = modelController?.chatList?[indexPath.row].id ?? ""
    }
  }
  
  //MARK: - UITableViewDelegate
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60.0
  }
}
