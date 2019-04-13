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
  var createDate: String { get set }
}

struct Message: MessageProtocol, Decodable {
  var id: String
  var text: String
  var author: User
  var createDate: String
  
  static let SERVER_DATE_FORMATTER = "yyyy-MM-dd HH:mm"
  
  static func getServerCurrentDate() -> String {
    let serverDateFormatter = DateFormatter()
    serverDateFormatter.dateFormat = Message.SERVER_DATE_FORMATTER
    
    return serverDateFormatter.string(from: Date())
  }
  
  static func getUiCreateDate(inMessage message: MessageProtocol) -> String {
    let calendar = Calendar.current
    let serverDateFormatter = DateFormatter()
    let uiDateFormatter = DateFormatter()
    serverDateFormatter.dateFormat = Message.SERVER_DATE_FORMATTER
    if let date = serverDateFormatter.date(from: message.createDate) {
      uiDateFormatter.dateFormat = calendar.isDateInToday(date) ? "HH:mm" : "dd.MM.yy"
      return uiDateFormatter.string(from: date)
    }
    
    return ""
  }
}
