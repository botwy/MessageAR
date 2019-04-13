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
  @IBOutlet weak var navigationBar: UINavigationItem!
  
  var modelController: ChatModelController?
  var chatId: String = ""
  
  let cellIdentifier = String(describing: ChatTableViewCell.self)
  
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
      
      messagesTable.register(
        UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier
      )
      messagesTable.delegate = self
      messagesTable.dataSource = self
      navigationBar.title =  modelController?.getAuthorBy(chatId: chatId)?.name
  }
  
  @IBAction func onClickSendButton(_ sender: UIButton) {
    guard
      let messageText = messageTextField.text,
      let author = modelController?.getAuthorBy(chatId: chatId) else {
      return
    }
    if (messageText.count == 0) {
      return
    }
    let message = Message(id: "", text: messageText, author: author, createDate: Message.getServerCurrentDate())
    modelController?.add(message: message, toChatWithId: chatId)
    
    messageTextField.text = ""
    messagesTable.reloadData()
  }

}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return modelController?.getMessagesBy(chatId: chatId).count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  let messageRow = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! ChatTableViewCell
    
    if let message = modelController?.getMessagesBy(chatId: chatId)[indexPath.row] {
      let isOwn = message.author.id == modelController?.getAuthorBy(chatId: chatId)?.id
      messageRow.setChatRowValue(message: message, isOwn: isOwn)
    }
    
    return messageRow
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
      cell.backgroundColor = UIColor.clear
  }
}
