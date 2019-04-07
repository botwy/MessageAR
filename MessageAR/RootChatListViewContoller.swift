//
//  RootChatListViewContoller.swift
//  MessageAR
//
//  Created by Admin on 07.04.2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation
import UIKit

class RootChatListRootViewController: UIViewController {
  @IBOutlet weak var chatListTable: UITableView!
  var chatStorage: ChatStorageProtocol = ChatStorage(chatList: createChatList())
  
  let cellIdentifier = String(describing: RootChatListTableViewCell.self)
  
  var chatList: [ChatProtocol] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    chatList = chatStorage.chatList
    chatListTable.register(
      UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier
    )
    chatListTable.delegate = self
    chatListTable.dataSource = self
  }
}

extension RootChatListRootViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.chatList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let chatCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! RootChatListTableViewCell
    
      let chat = chatList[indexPath.row]
      chatCell.setCellValue(chat: chat)
  
    
    return chatCell
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    cell.backgroundColor = UIColor.clear
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "ChatViewController", sender: indexPath)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? ChatViewController, let indexPath = sender as? IndexPath {
      let chat = chatList[indexPath.row]
      destination.currentUser = chat.author
      destination.messages = chat.messages
      destination.chatInStorage = chat
    }
    
  }
}
