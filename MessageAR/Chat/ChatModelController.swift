//
//  ChatModelController.swift
//  MessageAR
//
//  Created by Admin on 12.04.2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation

class ChatModelController {
  private var _chatList: [ChatDTOProtocol]?
  
  var chatList: [ChatDTOProtocol]? {
    set {
      _chatList = newValue
    }
    get {
      return _chatList
    }
  }
  
  init() { }
  
  init(chatList: [ChatDTOProtocol]) {
    self.chatList = chatList
  }
  
  func getChatBy(id: String) -> ChatDTOProtocol? {
    return chatList?.first{ $0.id == id }
  }
  
  func getAuthorBy(chatId: String) -> UserDTO? {
    return getChatBy(id: chatId)?.author
  }
  
  func getMessagesBy(chatId: String) -> [MessageDTO] {
    return getChatBy(id: chatId)?.messages ?? []
  }
  
  func getLastMessage(inChatWithId chatId: String) -> MessageDTO? {
    return getMessagesBy(chatId: chatId).last
  }
  
  func getMessage(byId messageId: String, inChatWithId chatId: String) -> MessageDTO? {
    return getMessagesBy(chatId: chatId).first{ $0.id == messageId }
  }
  
  func add(message: MessageDTO, toChatWithId id: String) {
     var chat = chatList?.first{ $0.id == id }
     chat?.messages.append(message)
  }
  
  func update(chatList: [ChatDTOProtocol]) {
    self.chatList = chatList
  }
}
