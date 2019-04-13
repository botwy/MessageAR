//
//  mock.swift
//  MessageAR
//
//  Created by Admin on 06.04.2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation

func createMessagesForFirstChat() -> [Message] {
  return [
    Message(id: "1", text: "hello, Helen", author: User(id: "1", name: "Dima"), createDate: "2019-04-01 11:15"),
    Message(id: "2", text: "hello, Dima", author: User(id: "2", name: "Helen"), createDate: "2019-04-13 17:15"),
    Message(id: "3", text: "how are you?", author: User(id: "1", name: "Dima"), createDate: "2019-04-12 11:15"),
  ]
}


func createMessagesForSecondChat() -> [Message] {
  return [
    Message(id: "4", text: "hello, Helen", author: User(id: "4", name: "Vika"), createDate: "2019-04-01 11:15"),
    Message(id: "5", text: "hello, Vika", author: User(id: "2", name: "Dasha"), createDate: "2019-04-05 11:35"),
    Message(id: "6", text: "how are you?", author: User(id: "2", name: "Dasha"), createDate: "2019-04-12 12:11"),
  ]
}

func createMessagesForThirdChat() -> [Message] {
  return [
    Message(id: "7", text: "hello, Helen", author: User(id: "5", name: "Dan"), createDate: "2019-04-03 09:11"),
    Message(id: "8", text: "hello, Dan", author: User(id: "1", name: "Dima"), createDate: "2019-04-07 13:22"),
    Message(id: "9", text: "how are you?", author: User(id: "1", name: "Dima"), createDate: "2019-04-13 16:45"),
  ]
}

func createChatList() -> [ChatProtocol] {
  return [
    Chat(id: "1", title: "Helen", author: User(id: "2", name: "Helen", profileIconPath: "princess.png"), messages: createMessagesForFirstChat()),
    Chat(id: "2", title: "Vika", author: User(id: "4", name: "Vika"), messages: createMessagesForSecondChat()),
    Chat(id: "3", title: "Dan Abramov", author: User(id: "5", name: "Dan Abramov", profileIconPath: "robot.png"), messages: createMessagesForThirdChat()),
  ]
}
