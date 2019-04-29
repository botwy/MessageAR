//
//  RootChatListPresentor.swift
//  MessageAR
//
//  Created by Dev on 29/04/2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation

protocol RootChatListPresentorDelegate {
  func fetchingStart()
  func fetchingEnd()
  func dataUpdateHandler()
}

class RootChatListPresentor: RootChatListPresentationProtocol {
  
  var modelController: ChatModelController
  var delegate: RootChatListPresentorDelegate?
  let store = UserDefaults.standard
  let storeKey = "chatList"
  
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
    let http = HttpFetch()
    http.createGetRequest(headers: nil){
      [weak self](data, response, error) in
      guard let self = self, let data = data, error == nil else { return }
      do {
        let chatResponseJson = try JSONDecoder().decode(ChatListResponseJson.self, from: data)
        guard let chatList = chatResponseJson.body else {
          return
        }
        self.store.set(data, forKey: self.storeKey)
        DispatchQueue.main.async {
          [weak self] in
          self?.modelController.update(chatList: chatList)
          self?.delegate?.fetchingEnd()
          self?.delegate?.dataUpdateHandler()
        }
      } catch let error {
        print(error)
      }
    }
  }
  
  func getChat(by indexPath: IndexPath) -> ChatProtocol {
    return chatList[indexPath.row]
  }
  
  func viewDidLoadHandler() {
    DispatchQueue.global(qos: .background).async {
      [weak self] in
      if let self = self,
        let data = self.store.data(forKey: self.storeKey),
        let chatResponseJson = try? JSONDecoder().decode(ChatListResponseJson.self, from: data),
        let chatList = chatResponseJson.body {
        
        DispatchQueue.main.async {
          [weak self] in
          self?.modelController.update(chatList: chatList)
          self?.delegate?.dataUpdateHandler()
        }
        
      }
    }
    delegate?.fetchingStart()
    fetchChatList()
  }
}
