//
//  Chat.swift
//  MessageAR
//
//  Created by Admin on 07.04.2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation

protocol ChatProtocol {
  var id: String { get }
  var title: String { get set }
  var author: UserProtocol { get set }
  var messages: [MessageProtocol] { get set }
}

class Chat: ChatProtocol {
  var id: String
  var title: String
  var author: UserProtocol
  var messages: [MessageProtocol] = []
  
  init(id: String, title: String, author: UserProtocol, messages: [MessageProtocol]) {
    self.id = id
    self.title = title
    self.author = author
    self.messages = messages
  }
}
