//
//  RegisterViewModel.swift
//  GameVerseApp
//
//  Created by beyyzgur on 13.01.2026.
//

import FirebaseAuth
import FirebaseFirestore

final class RegisterViewModel {
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    weak var view: RegisterViewControllerInterface?
    
    init(view: RegisterViewControllerInterface) {
        self.view = view
    }
    
    func isFormValid() -> Bool {
        guard !username.isEmpty,
              !password.isEmpty,
              password.count >= 6,
              email.contains("@"),
              password == confirmPassword else {
            return false
        }
        return true
    }
    
    func register() {
        guard isFormValid() else {
            view?.makeAlert(title: "Error", message: "Invalid Form Informations", onOK: nil)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self else { return }
            if let error = error {
                view?.makeAlert(title: "Error", message: error.localizedDescription, onOK: nil)
                return
            }
            guard let uid = result?.user.uid else {
                view?.makeAlert(title: "Error", message: "User ID not found", onOK: nil)
                return }
            
            saveUserProfile(uid: uid)
        }
    }
    
    func saveUserProfile(uid: String) {
        let db = Firestore.firestore()
        
        let userData: [String : Any] = [
            "username": username,
            "email": email,
            "createdAt": Timestamp()
        ]
        
        db.collection("users")
            .document(uid)
            .setData(userData) { [weak self] error in
                guard let self else { return }
                if let error = error {
                    self.view?.makeAlert(title: "Error", message: error.localizedDescription, onOK: nil)
                }
                else {
                    self.view?.makeAlert(title: "Success", message: "Succesfully registered, please sign in!") {
                        self.view?.popToWelcoming()
                    }
                }
            }
    }
}
