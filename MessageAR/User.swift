//
//  User.swift
//  MessageAR
//
//  Created by Admin on 06.04.2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation

protocol UserProtocol: PersonProtocol {
  var profileIconPath: String? { get set }
}

struct User: UserProtocol {
  var id: String
  var name: String
  var profileIconPath: String? = nil
  
  init (id: String, name: String) {
    self.id = id
    self.name = name
  }
  
  init (id: String, name: String, profileIconPath: String) {
    self.id = id
    self.name = name
    self.profileIconPath = profileIconPath
  }
}
