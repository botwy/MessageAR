//
//  ChatRowViewController.swift
//  MessageAR
//
//  Created by Admin on 06.04.2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var ownMessageLabel: UILabel!
  @IBOutlet weak var addInfo: UILabel!
  @IBOutlet weak var ownAddInfo: UILabel!

  
  func setChatRowValue(message: MessageProtocol, isOwn: Bool) {
    let createDate = Message.getUiCreateDate(inMessage: message)
    if (isOwn) {
      ownMessageLabel.text = message.text
      ownAddInfo.text = createDate
      messageLabel.isHidden = true
      addInfo.isHidden = true
      return
    }
    messageLabel.text = message.text
    addInfo.text = createDate
    ownMessageLabel.isHidden = true
    ownAddInfo.isHidden = true
  }
}
