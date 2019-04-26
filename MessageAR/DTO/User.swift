//
//  User.swift
//  MessageAR
//
//  Created by Dev on 26/04/2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation

protocol UserDTOProtocol: PersonDTOProtocol {
  var profileIconPath: String? { get set }
}

struct UserDTO: UserDTOProtocol, Codable {
  var id: String
  var name: String
  var profileIconPath: String?
  
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
