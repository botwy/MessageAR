//
//  RootChatListPresentor.swift
//  MessageAR
//
//  Created by Dev on 29/04/2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation

protocol RootChatListPresentorDelegate: class {
  func fetchingStart()
  func fetchingEnd()
  func dataUpdateHandler()
}

class RootChatListPresentor: RootChatListPresentationProtocol {
  
  var modelController: ChatModelController
  weak var delegate: RootChatListPresentorDelegate?
  
  init() {
    self.modelController = ChatModelController()
  }
  
  init(modelController: ChatModelController) {
    self.modelController = modelController
  }
  
  var chatList: [ChatProtocol] {
    return modelController.chatList ?? []
  }
  
  var chatCount: Int {
    return chatList.count
  }
  
  private func fetchChatList() {
    modelController.fetchChatList{
      [weak self] in
      self?.delegate?.fetchingEnd()
      self?.delegate?.dataUpdateHandler()
    }
  }
  
  func getChat(by indexPath: IndexPath) -> ChatProtocol {
    return chatList[indexPath.row]
  }
  
  func viewDidLoadHandler() {
    modelController.readFromStore {
      [weak self] in
      self?.delegate?.dataUpdateHandler()
    }
    delegate?.fetchingStart()
    fetchChatList()
  }
}
