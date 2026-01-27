//
//  LoginViewController.swift
//  GameVerseApp
//
//  Created by beyyzgur on 14.01.2026.
//

import UIKit

protocol LoginViewControllerInterface: AnyObject,
                                       AlertPresentable {
    func navigateToTabBar()
}

final class LoginViewController: UIViewController {
    @IBOutlet weak var loginTitle1: UILabel!
    @IBOutlet weak var loginTitle2: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private lazy var viewModel = LoginViewModel(view: self)
    
    private var textFields: [UITextField] {
       return [ emailTextField,
        passwordTextField
       ]
    }
    
    // MARK: - life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
    }
    
    // MARK: - IBAction & @objc funcs
    
    @IBAction func signInButtonClicked(_ sender: UIButton) {
        viewModel.login()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text ?? ""
        
        switch textField {
        case emailTextField:
            viewModel.emailTextField = text
        case passwordTextField:
            viewModel.passwordTextField = text
        default:
            break
        }
    }
    
    // MARK: - functions
    
    func setupTextFields() {
        textFields.forEach {
            $0.delegate = self
            $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
    }
    
}

// MARK: - extensions

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let index = textFields.firstIndex(where: { $0 === textField }),
           index + 1 < textFields.count {
            textFields[ index + 1 ].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
           return true
    }
}

extension LoginViewController: LoginViewControllerInterface {
    func navigateToTabBar() {
        viewModel.storyboardNavigableManager.push(storyboardId: .tabBar,
                                                  delegate: self)
    }
}
