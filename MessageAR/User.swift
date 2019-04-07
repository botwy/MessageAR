//
//  User.swift
//  MessageAR
//
//  Created by Admin on 06.04.2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation

protocol UserProtocol: PersonProtocol { }

struct User: UserProtocol {
  var id: String
  var name: String
}
