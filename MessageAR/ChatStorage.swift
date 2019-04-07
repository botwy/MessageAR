//
//  ChatStorage.swift
//  MessageAR
//
//  Created by Admin on 07.04.2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation

protocol ChatStorageProtocol {
  var chatList: [ChatProtocol] { get set }
}

struct ChatStorage: ChatStorageProtocol {
  var chatList: [ChatProtocol]
}
