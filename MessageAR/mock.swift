//
//  mock.swift
//  MessageAR
//
//  Created by Admin on 06.04.2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation

func createCurrentUser() -> User {
  return User(id: "1", name: "Dima")
}

func createMessages() -> [Message] {
  return [
    Message(id: "1", text: "hello, Dasha", author: User(id: "1", name: "Dima")),
    Message(id: "2", text: "hello, Dima", author: User(id: "2", name: "Dasha")),
    Message(id: "3", text: "how are you?", author: User(id: "1", name: "Dima")),
  ]
}


func createDashaMessages() -> [Message] {
  return [
    Message(id: "1", text: "hello, Helen", author: User(id: "1", name: "Dima")),
    Message(id: "2", text: "hello, Dima", author: User(id: "2", name: "Dasha")),
    Message(id: "3", text: "how are you?", author: User(id: "1", name: "Dima")),
  ]
}


func createVikaMessages() -> [Message] {
  return [
    Message(id: "4", text: "hello, Helen", author: User(id: "4", name: "Vika")),
    Message(id: "5", text: "hello, Vika", author: User(id: "2", name: "Dasha")),
    Message(id: "6", text: "how are you?", author: User(id: "2", name: "Dasha")),
  ]
}

func createDanMessages() -> [Message] {
  return [
    Message(id: "7", text: "hello, Helen", author: User(id: "5", name: "Dan")),
    Message(id: "8", text: "hello, Dan", author: User(id: "1", name: "Dima")),
    Message(id: "9", text: "how are you?", author: User(id: "1", name: "Dima")),
  ]
}

func createChatList() -> [ChatProtocol] {
  return [
    Chat(id: "1", title: "Helen", author: User(id: "2", name: "Helen", profileIconPath: "princess.png"), messages: createDashaMessages()),
    Chat(id: "2", title: "Vika", author: User(id: "4", name: "Vika"), messages: createVikaMessages()),
    Chat(id: "4", title: "Dan Abramov", author: User(id: "5", name: "Dan Abramov", profileIconPath: "robot.png"), messages: createDanMessages()),
  ]
}
