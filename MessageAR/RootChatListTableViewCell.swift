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
  @IBOutlet weak var profileIcon: UIImageView!
  @IBOutlet weak var lastUpdate: UILabel!
  
  func setCellValue(chat: ChatProtocol) {
    chatTitle.text = chat.title
    if let profileIconPath = chat.author.profileIconPath,
      let image = UIImage(named: profileIconPath) {
      profileIcon.image = image
    }
    guard let lastMessage = chat.messages.last else {
      return
    }
    message.text = lastMessage.text
    lastUpdate.text = Message.getUiCreateDate(inMessage: lastMessage)
  }
    
}
