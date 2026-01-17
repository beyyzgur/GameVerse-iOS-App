//
//  AlertPresentable.swift
//  GameVerseApp
//
//  Created by beyyzgur on 15.01.2026.
//
import UIKit

protocol AlertPresentable {
    func makeAlert(title: String, message: String, onOK: (() -> Void)?)
}

extension AlertPresentable where Self: UIViewController {
    func makeAlert(title: String, message: String, onOK: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
            onOK?()
        }
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
