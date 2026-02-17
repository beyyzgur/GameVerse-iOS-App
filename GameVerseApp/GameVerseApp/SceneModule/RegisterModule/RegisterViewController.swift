//
//  RegisterViewController.swift
//  GameVerseApp
//
//  Created by beyyzgur on 13.01.2026.
//

import UIKit

protocol RegisterViewControllerInterface: AnyObject,
                                          AlertPresentable { // delegate? pattern
    func popToWelcoming()
}

final class RegisterViewController: UIViewController {
    @IBOutlet private weak var registerTitle1: UILabel!
    @IBOutlet private weak var registerTitle2: UILabel!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    private lazy var viewModel = RegisterViewModel(view: self)
    
    private var textFields: [UITextField] {
        return [ // return yazmamak life cycle açısından riskliymiş
            usernameTextField,
            emailTextField,
            passwordTextField,
            confirmPasswordTextField
        ]
    }
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFields()
        setsignUpButton()
    }
    
    // MARK: - IBAction & @objc functions
    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        viewModel.register()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text ?? ""
        
        switch textField {
        case usernameTextField:
            viewModel.username = text
        case emailTextField:
            viewModel.email = text
        case passwordTextField:
            viewModel.password = text
        case confirmPasswordTextField:
            viewModel.confirmPassword = text
        default:
            break
        }
    }
    
    // MARK: - functions
    func setTextFields() {
        textFields.forEach {
            $0.delegate = self
            $0.addTarget(self,
                         action: #selector(textFieldDidChange(_:)),
                         for: .editingChanged)
        }
        
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
    }
    
    private func setsignUpButton() {
        signUpButton.layer.cornerRadius = 12
    }
}

// MARK: - extensions

extension RegisterViewController: UITextFieldDelegate {
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

extension RegisterViewController: RegisterViewControllerInterface {
    func popToWelcoming() {
        self.navigationController?.popViewController(animated: true)
    }
}
