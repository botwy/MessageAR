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
  var author: User { get set }
  var messages: [Message] { get set }
}

class Chat: ChatProtocol, Decodable {
  var id: String
  var title: String
  var author: User
  var messages: [Message] = []
  
  init(id: String, title: String, author: User, messages: [Message]) {
    self.id = id
    self.title = title
    self.author = author
    self.messages = messages
  }
}
