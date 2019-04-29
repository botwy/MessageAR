//
//  ServerResponseModels.swift
//  MessageAR
//
//  Created by Dev on 29/04/2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation

struct ChatListResponseJson: Decodable {
  var success: Bool?
  var body: [Chat]?
}

struct ChatMessageRequestJson: Encodable {
  var chatId: String
  var message: Message
}
