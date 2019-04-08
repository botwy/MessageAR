//
//  RootChatListTableViewCell.swift
//  MessageAR
//
//  Created by Admin on 07.04.2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import UIKit

class RootChatListTableViewCell: UITableViewCell {
  @IBOutlet weak var chatTitle: UILabel!
  @IBOutlet weak var message: UILabel!
  
  func setCellValue(chat: ChatProtocol) {
    chatTitle.text = chat.title
    message.text = chat.messages.last?.text ?? ""
  }
    
}
