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
  
  func setDefaultIcon() {
    let profileIcon = "default.png"
    let image = UIImage(named: profileIcon)
    self.profileIcon.image = image
  }
  
  func setProfileIcon(profileIconPath: String?) {
    guard let profileIcon = profileIconPath else {
      self.setDefaultIcon()
      return
    }
    let profileIconUrl = HttpFetch().getHost() + "/" + profileIcon
    guard let url = URL(string: profileIconUrl) else { return }
    do {
      let data = try Data(contentsOf: url)
      let image = UIImage(data: data)
      
      self.profileIcon.image = image
      
    } catch let error {
      print(error)
    }
  }
  
  func setCellValue(chat: ChatProtocol) {
    chatTitle.text = chat.title
    self.setProfileIcon(profileIconPath: chat.author.profileIconPath)
    
    guard let lastMessage = chat.messages.last else {
      return
    }
    message.text = lastMessage.text
    lastUpdate.text = Message.getUiCreateDate(inMessage: lastMessage)
  }
}
