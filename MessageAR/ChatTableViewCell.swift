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
  
  func setChatRowValue(message: MessageProtocol, isOwn: Bool) {
    if (isOwn) {
      ownMessageLabel.text = message.text
      messageLabel.isHidden = true
      return
    }
    messageLabel.text = message.text
    ownMessageLabel.isHidden = true
  }
}
