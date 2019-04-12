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
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    let date = dateFormatter.date(from: "12:35")
    if let date = date {
      lastUpdate.text = dateFormatter.string(from: date)
    }
    
    chatTitle.text = chat.title
    message.text = chat.messages.last?.text ?? ""
    if let profileIconPath = chat.author.profileIconPath,
      let image = UIImage(named: profileIconPath)
      {
      profileIcon.image = image
    }
  }
    
}
