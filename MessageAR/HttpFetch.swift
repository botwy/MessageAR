//
//  HttpFetch.swift
//  MessageAR
//
//  Created by Dev on 12/04/2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation

class HttpFetch:  NSObject, URLSessionDelegate, URLSessionDownloadDelegate {
  private let host = "http://localhost:5656"
  private var serviceUrl = "/chat"
  var responseHandler: ((Data?, URLResponse?, Error?) -> Void)?
  
  func getUrl() -> String {
    return host + serviceUrl
  }
  
  func setMessageService() {
    serviceUrl = "/chat/message"
  }
  
  func setAuthService() {
    serviceUrl = "/auth"
  }
  
  func createGetRequest(responseHandler: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
    self.responseHandler = responseHandler
    guard let url = URL(string: getUrl()) else { return }
    let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    
    let sessionDataTask = session.dataTask(with: url, completionHandler: responseHandler)
    sessionDataTask.resume()
  }
  
  func createPostRequest<T:Encodable>(requestPayload: T, responseHandler: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
    self.responseHandler = responseHandler
    guard let url = URL(string: getUrl()) else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONEncoder().encode(requestPayload) else {
      return
    }
    request.httpBody = httpBody
    let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    let sessionDataTask = session.dataTask(with: request, completionHandler: responseHandler)
    sessionDataTask.resume()
  }
  
  public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
    do {
      let data = try Data(contentsOf: location)
      guard let responseHandler = responseHandler else { return }
      
      DispatchQueue.main.async {
        responseHandler(data, nil, nil)
      }
    } catch let error {
      print(error)
    }
    
  }
}
