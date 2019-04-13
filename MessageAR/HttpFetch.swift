//
//  HttpFetch.swift
//  MessageAR
//
//  Created by Dev on 12/04/2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation

class HttpFetch:  NSObject, URLSessionDelegate, URLSessionDownloadDelegate {
  let urlString = "http://localhost:5656/chat"
  var responseHandler: ((Data?, URLResponse?, Error?) -> Void)?
  
  
  func createGetRequest(responseHandler: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
    self.responseHandler = responseHandler
    guard let url = URL(string: urlString) else { return }
    let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    
    let sessionDataTask = session.dataTask(with: url, completionHandler: responseHandler)
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
