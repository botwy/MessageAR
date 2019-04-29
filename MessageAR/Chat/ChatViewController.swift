//
//  ViewController.swift
//  MessageAR
//
//  Created by Admin on 06.04.2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import UIKit

protocol ChatPresentationProtocol {
  var modelController: ChatModelController { get set }
  var messageCount: Int { get }
  var title: String { get }
  var delegate: ChatPresentorDelegate? { get set }
  func getMessage(by indexPath: IndexPath) -> MessageProtocol
  func isOwn(message: MessageProtocol) -> Bool
  func createMessage(messageText: String?)
}

class ChatViewController: UIViewController, ChatPresentorDelegate {
  
  @IBOutlet weak var messageTextField: UITextField!
  @IBOutlet weak var messagesTable: UITableView!
  @IBOutlet weak var navigationBar: UINavigationItem!
  
  var presentor: ChatPresentationProtocol?
  
  let cellIdentifier = String(describing: ChatTableViewCell.self)
  
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
      
      messagesTable.register(
        UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier
      )
      messagesTable.delegate = self
      messagesTable.dataSource = self
      messagesTable.estimatedRowHeight = 44
      messagesTable.rowHeight = UITableView.automaticDimension
      
      presentor?.delegate = self
      navigationBar.title = presentor?.title
  }
  
  func fetchingEnd() {
    messageTextField.text = ""
    messagesTable.reloadData()
  }
  
  @IBAction func onClickSendButton(_ sender: UIButton) {
    presentor?.createMessage(messageText: messageTextField.text)
  }

}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presentor?.messageCount ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  let messageRow = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! ChatTableViewCell
    
    if let message = presentor?.getMessage(by: indexPath), let isOwn = presentor?.isOwn(message: message) {
      messageRow.setChatRowValue(message: message, isOwn: isOwn)
    }
    
    return messageRow
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
      cell.backgroundColor = UIColor.clear
  }
}
