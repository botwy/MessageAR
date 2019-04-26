//
//  Chat.swift
//  MessageAR
//
//  Created by Admin on 07.04.2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation

protocol ChatDTOProtocol {
  var id: String { get }
  var title: String { get set }
  var author: UserDTO { get set }
  var messages: [MessageDTO] { get set }
}

class ChatDTO: ChatDTOProtocol, Decodable {
  var id: String
  var title: String
  var author: UserDTO
  var messages: [MessageDTO] = []
  
  init(id: String, title: String, author: UserDTO, messages: [MessageDTO]) {
    self.id = id
    self.title = title
    self.author = author
    self.messages = messages
  }
}

struct ChatListResponseJson: Decodable {
  var success: Bool?
  var body: [ChatDTO]?
}

struct ChatMessageRequestJson: Encodable {
  var chatId: String
  var message: MessageDTO
}
