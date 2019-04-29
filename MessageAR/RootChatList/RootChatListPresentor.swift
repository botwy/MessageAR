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
      [unowned self](data, response, error) in
      guard let data = data, error == nil else { return }
      do {
        let chatResponseJson = try JSONDecoder().decode(ChatListResponseJson.self, from: data)
        guard let chatList = chatResponseJson.body else {
          return
        }
        self.store.set(data, forKey: self.storeKey)
        DispatchQueue.main.async {
          self.modelController.update(chatList: chatList)
          self.delegate?.fetchingEnd()
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
    if let data = store.data(forKey: storeKey),
    let chatResponseJson = try? JSONDecoder().decode(ChatListResponseJson.self, from: data),
    let chatList = chatResponseJson.body {
      self.modelController.update(chatList: chatList)
    }
    delegate?.fetchingStart()
    fetchChatList()
  }
}
