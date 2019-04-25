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
  struct Constants {
    static let AuthViewHeight: CGFloat = 250
    static let AuthViewWidth: CGFloat = 500
  }
  
  private lazy var authPanel: AuthPanelView = {
    let view = AuthPanelView(frame: CGRect(x: 50, y: 500, width: Constants.AuthViewWidth, height: Constants.AuthViewHeight))
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 10
    view.backgroundColor = UIColor.white
    
    return view
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    authPanel.delegate = self
    view.addSubview(authPanel)
    configureConstraints()
  }
  
  func configureConstraints() {
    authPanel.widthAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.widthAnchor, constant: 0).isActive = true
    authPanel.heightAnchor.constraint(equalToConstant: Constants.AuthViewHeight).isActive = true
    authPanel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    authPanel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
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
