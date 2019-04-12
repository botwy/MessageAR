//
//  Message.swift
//  MessageAR
//
//  Created by Admin on 06.04.2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation

protocol MessageProtocol {
  var id: String { get }
  var text: String { get set }
  var author: User { get set }
}

struct Message: MessageProtocol, Decodable {
  var id: String
  var text: String
  var author: User
}
