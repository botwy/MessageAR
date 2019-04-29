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
  private let store = UserDefaults.standard
  private let storeKey = "chatList"
  
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
  
  func readFromStore(completionHandler: @escaping () -> Void) {
    DispatchQueue.global(qos: .background).async {
      [weak self] in
      if let self = self,
        let data = self.store.data(forKey: self.storeKey),
        let chatResponseJson = try? JSONDecoder().decode(ChatListResponseJson.self, from: data),
        let chatList = chatResponseJson.body {
        self.update(chatList: chatList)
        
        DispatchQueue.main.async {
          completionHandler()
        }
        
      }
    }
  }
  
  private func requestSuccessHandler(data: Data, completionHandler: @escaping () -> Void) {
    do {
      let chatResponseJson = try JSONDecoder().decode(ChatListResponseJson.self, from: data)
      guard let chatList = chatResponseJson.body else {
        return
      }
      self.store.set(data, forKey: self.storeKey)
      self.update(chatList: chatList)
      DispatchQueue.main.async {
        completionHandler()
      }
    } catch let error {
      print(error)
    }
  }
  
  func fetchChatList(completionHandler: @escaping () -> Void) {
    let http = HttpFetch()
    http.createGetRequest(headers: nil) {
      [weak self](data, response, error) in
      guard let self = self, let data = data, error == nil else { return }
      self.requestSuccessHandler(data: data, completionHandler: completionHandler)
    }
  }
  
  func createMessage(chatId: String, messageText: String, completionHandler: @escaping () -> Void) {
    guard let author = getAuthorBy(chatId: chatId) else {
        return
    }
    
    let message = Message(id: "", text: messageText, author: author, createDate: Message.getServerCurrentDate())
    
    let requestPayload = ChatMessageRequestJson(chatId: chatId, message: message)
    let http = HttpFetch()
    http.setMessageService()
    http.createPostRequest(requestPayload: requestPayload) {
      [weak self](data, url, error) in
      guard let self = self, let data = data, error == nil else { return }
      self.requestSuccessHandler(data: data, completionHandler: completionHandler)
    }
  }
}
