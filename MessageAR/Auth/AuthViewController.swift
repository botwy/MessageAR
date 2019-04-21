//
//  AuthViewController.swift
//  MessageAR
//
//  Created by Admin on 14.04.2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation
import UIKit

struct AuthRequestPayload: Encodable {
  let userName: String
}

struct AuthServerResponse: Decodable {
  let success: Bool
}

class AuthViewController: UIViewController, AuthPanelDelegate {
  private lazy var authPanel: AuthPanelView = {
    let view = AuthPanelView(frame: CGRect(x: 50, y: 500, width: 350, height: 250))
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 10
    view.backgroundColor = UIColor.white
    
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    authPanel.delegate = self
    view.addSubview(authPanel)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    authPanel.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY*0.8)
    authPanel.transform = CGAffineTransform(rotationAngle: 0.5).concatenating(CGAffineTransform(scaleX: 0.1, y: 0.5))
    authPanel.transform = CGAffineTransform.identity
  }
  
  func loginButtonHandler(sender: UIButton) {
    guard let userName = authPanel.userNameField.text, let password = authPanel.passwordField.text else {
      return
    }
    let http = HttpFetch()
    http.setAuthService()
    guard let loginData = String(format: "%@:%@", userName, password).data(using: String.Encoding.utf8) else { return }
    let base64LoginData = loginData.base64EncodedString()
    let headers: [(field: String, value: String)] = [(field: "Authorization", value: "Basic \(base64LoginData)")]
    http.createGetRequest(headers: headers) {
      [unowned self](data, response, error) in
      guard let data = data, error == nil else { return }
      do {
        let status = try JSONDecoder().decode(AuthServerResponse.self, from: data)
        if (status.success) {
          DispatchQueue.main.async {
            self.performSegue(withIdentifier: "AuthToRootChatListSegue", sender: nil)
          }
        } else {
          DispatchQueue.main.async {
            self.authPanel.errorLabel.isHidden = false
          }
        }
      } catch let error {
        print(error)
      }
    }
  }
}
