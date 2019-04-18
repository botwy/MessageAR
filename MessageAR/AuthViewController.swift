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

class AuthViewController: UIViewController {
  @IBOutlet weak var authView: UIView!
  @IBOutlet weak var userName: UITextField!
  @IBOutlet weak var password: UITextField!
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var loginButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
      errorLabel.isHidden = true
      authView.layer.cornerRadius = 20
      loginButton.layer.borderWidth = 1
      loginButton.layer.borderColor = UIColor.blue.cgColor
      loginButton.layer.cornerRadius = 10
  }
  
  @IBAction func changeUserName(_ sender: UITextField) {
    self.errorLabel.isHidden = true
  }
  
  @IBAction func loginButtonHandler(_ sender: UIButton) {
    guard let userName = self.userName.text else {
      return
    }
    let http = HttpFetch()
    http.setAuthService()
    http.createPostRequest(requestPayload: AuthRequestPayload(userName: userName)) {
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
            self.errorLabel.isHidden = false
          }
        }
      } catch let error {
        print(error)
      }
    }
  }
}
