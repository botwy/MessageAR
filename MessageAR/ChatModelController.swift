//
//  ChatModelController.swift
//  MessageAR
//
//  Created by Admin on 12.04.2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation

class ChatModelController {
  private var _chatList: [ChatProtocol]?
  
  var chatList: [ChatProtocol]? {
    set {
      _chatList = newValue
    }
    get {
      return _chatList
    }
  }
  
  init() { }
  
  init(chatList: [ChatProtocol]) {
    self.chatList = chatList
  }
  
  func getChatBy(id: String) -> ChatProtocol? {
    return chatList?.first{ $0.id == id }
  }
  
  func getAuthorBy(chatId: String) -> User? {
    return getChatBy(id: chatId)?.author
  }
  
  func getMessagesBy(chatId: String) -> [Message] {
    return getChatBy(id: chatId)?.messages ?? []
  }
  
  func getLastMessage(inChatWithId chatId: String) -> Message? {
    return getMessagesBy(chatId: chatId).last
  }
  
  func getMessage(byId messageId: String, inChatWithId chatId: String) -> Message? {
    return getMessagesBy(chatId: chatId).first{ $0.id == messageId }
  }
  
  func add(message: Message, toChatWithId id: String) {
     var chat = chatList?.first{ $0.id == id }
     chat?.messages.append(message)
  }
  
  func update(chatList: [ChatProtocol]) {
    self.chatList = chatList
  }
}
