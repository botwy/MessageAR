//
//  AuthPanelView.swift
//  MessageAR
//
//  Created by Admin on 21.04.2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import Foundation
import UIKit

protocol AuthPanelDelegate {
  func loginButtonHandler(sender: UIButton)
}

class AuthPanelView: UIView {
  var delegate: AuthPanelDelegate?
  
  private lazy var userNameLabel: UILabel = {
    let label = UILabel(frame: CGRect(x: 10, y: 40, width: 80, height: 20))
    label.text = "имя"
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  lazy var userNameField: UITextField = {
    let textField = UITextField(frame: CGRect(x: 90, y: 40, width: 240, height: 30))
    textField.placeholder = "введите логин"
    textField.autocorrectionType = .no
    textField.clearButtonMode = .whileEditing
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .roundedRect
    textField.autocapitalizationType = .none
    textField.delegate = self
    
    return textField
  }()
  
  private lazy var passwordLabel: UILabel = {
    let label = UILabel(frame: CGRect(x: 10, y: 100, width: 80, height: 20))
    label.text = "пароль"
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  lazy var passwordField: UITextField = {
    let textField = UITextField(frame: CGRect(x: 90, y: 100, width: 240, height: 30))
    textField.placeholder = "введите пароль"
    textField.autocorrectionType = .no
    textField.clearButtonMode = .whileEditing
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .roundedRect
    textField.isSecureTextEntry = true
    textField.autocapitalizationType = .none
    textField.delegate = self
    
    return textField
  }()
  
  private lazy var loginButton: UIButton = {
    let button = UIButton(frame: CGRect(x: 10, y: 160, width: 330, height: 40))
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("войти", for: .normal)
    button.setTitleColor(self.tintColor, for: .normal)
    button.setTitleColor(UIColor.gray, for: .disabled)
    button.layer.borderWidth = 1
    button.layer.borderColor = self.tintColor.cgColor
    button.layer.cornerRadius = 10
    button.addTarget(self, action: #selector(loginButtonHandler(sender:)), for: .touchUpInside)
    
    return button
  }()
  
  lazy var errorLabel: UILabel = {
    let label = UILabel(frame: CGRect(x: 10, y: 220, width: 330, height: 20))
    label.text = "неправильный логин или пароль"
    label.textAlignment = .center
    label.textColor = UIColor.red
    label.translatesAutoresizingMaskIntoConstraints = false
    label.isHidden = true
    
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(userNameLabel)
    self.addSubview(userNameField)
    self.addSubview(passwordLabel)
    self.addSubview(passwordField)
    self.addSubview(loginButton)
    self.addSubview(errorLabel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc
  func loginButtonHandler(sender: UIButton) {
    if let delegate = delegate {
      delegate.loginButtonHandler(sender: sender)
    }
  }
}

extension AuthPanelView: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.6, options: .beginFromCurrentState, animations: {
      
      textField.layer.borderColor = self.tintColor.cgColor
      textField.layer.shadowOffset = CGSize.zero
      textField.layer.borderWidth = 1
      textField.layer.shadowColor = self.tintColor.cgColor
      textField.layer.shadowOpacity = 0.5
      textField.layer.shadowRadius = 5
    }, completion: nil)
    
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.6, options: .beginFromCurrentState, animations: {
      
      textField.layer.borderColor = nil
      textField.layer.shadowOffset = CGSize.zero
      textField.layer.borderWidth = 0
      textField.layer.shadowColor = nil
      textField.layer.shadowOpacity = 0
      textField.layer.shadowRadius = 0
    }, completion: nil)
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    self.errorLabel.isHidden = true
    return true
  }
}
