//
//  HttpFetch.swift
//  MessageAR
//
//  Created by Dev on 12/04/2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation

final class HttpFetch {
  static let shared = HttpFetch()
  
  private let host: String
  private var serviceUrl: String
  private let credential = URLCredential(user: "test", password: "test", persistence: .permanent)
  private let session: URLSession

  private init() {
    host = "http://localhost:5656"
    serviceUrl = "/chat"
    session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
  }
  
  private init(configuration: URLSessionConfiguration) {
    host = "http://localhost:5656"
    serviceUrl = "/chat"
    session = URLSession(configuration: configuration)
  }
  
  func getHost() -> String {
    return host
  }
  
  func getUrl() -> String {
    return host + serviceUrl
  }
  
  func setChatService() {
    serviceUrl = "/chat"
  }
  
  func setMessageService() {
    serviceUrl = "/chat/message"
  }
  
  func setAuthService() {
    serviceUrl = "/auth"
  }
  
  func createGetRequest(headers: [(field: String, value: String)]?, responseHandler: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
    guard let url = URL(string: getUrl()) else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
    
    if let headers = headers {
      headers.forEach {
        (header: (field: String, value: String)) in
        request.setValue(header.value, forHTTPHeaderField: header.field)
      }
    }
    
    let sessionDataTask = session.dataTask(with: request, completionHandler: responseHandler)
    sessionDataTask.resume()
  }
  
  func createPostRequest<T:Encodable>(requestPayload: T, responseHandler: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
    guard let url = URL(string: getUrl()) else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONEncoder().encode(requestPayload) else {
      return
    }
    request.httpBody = httpBody
  
    let sessionDataTask = session.dataTask(with: request, completionHandler: responseHandler)
    sessionDataTask.resume()
  }
  
}
