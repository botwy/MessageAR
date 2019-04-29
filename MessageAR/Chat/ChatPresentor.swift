//
//  ChatPresentor.swift
//  MessageAR
//
//  Created by Dev on 29/04/2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation

protocol ChatPresentorDelegate {
  func dataUpdateHandler()
  func fetchingEnd()
}

class ChatPresentor: ChatPresentationProtocol {
  var modelController: ChatModelController
  var chatId: String
  var delegate: ChatPresentorDelegate?
  
  init (chatId: String) {
    self.chatId = chatId
    modelController = ChatModelController()
  }
  
  init (chatId: String, modelController: ChatModelController) {
    self.chatId = chatId
    self.modelController = modelController
  }
  
  var messageCount: Int {
    return modelController.getMessagesBy(chatId: chatId).count
  }
  
  var title: String {
    return modelController.getAuthorBy(chatId: chatId)?.name ?? ""
  }
  
  func getMessage(by indexPath: IndexPath) -> MessageProtocol {
    return modelController.getMessagesBy(chatId: chatId)[indexPath.row]
  }
  
  func isOwn(message: MessageProtocol) -> Bool {
    return message.author.id == modelController.getAuthorBy(chatId: chatId)?.id
  }
  
  func createMessage(messageText: String?) {
    guard let messageText = messageText else {
        return
    }
    if (messageText.count == 0) {
      return
    }
    modelController.createMessage(chatId: chatId, messageText: messageText) {
      [weak self] in
      self?.delegate?.fetchingEnd()
      self?.delegate?.dataUpdateHandler()
    }
  }
  
}
