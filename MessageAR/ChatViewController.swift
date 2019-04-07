//
//  ViewController.swift
//  MessageAR
//
//  Created by Admin on 06.04.2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
  @IBOutlet weak var messageTextField: UITextField!
  @IBOutlet weak var messagesTable: UITableView!
  
  var chatInStorage: ChatProtocol?
  var currentUser: UserProtocol?
  var messages: [MessageProtocol]? {
    didSet {
      if let messageList = messages {
        chatInStorage?.messages = messageList
      }
    }
  }
  
  let cellIdentifier = String(describing: ChatTableViewCell.self)
  
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
      
      messagesTable.register(
        UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier
      )
      messagesTable.delegate = self
      messagesTable.dataSource = self
  }
  
  @IBAction func onClickSendButton(_ sender: UIButton) {
    guard let messageText = messageTextField.text, let author = currentUser else {
      return
    }
    if (messageText.count == 0) {
      return
    }
    
    messages?.append(Message(id: "", text: messageText, author: author))
    messageTextField.text = ""
    messagesTable.reloadData()
  }

}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.messages?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  let messageRow = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! ChatTableViewCell
    
    if let message = messages?[indexPath.row] {
      let isOwn = message.author.id == self.currentUser?.id
      messageRow.setChatRowValue(message: message, isOwn: isOwn)
    }
    
    return messageRow
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
      cell.backgroundColor = UIColor.clear
  }
}
