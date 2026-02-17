//
//  SpinnerDisplayable.swift
//  GameVerseApp
//
//  Created by beyyzgur on 15.02.2026.
//

import UIKit

// MARK: - SpinnerDisplayable
public protocol SpinnerDisplayable {
    func showProgress()
    func removeProgress()
}

extension SpinnerDisplayable where Self: UIViewController {
    func showProgress() {
        DispatchQueue.main.async {
            if self.view.subviews.contains(where: { $0.tag == 999 }) {
                return
            }
            let spinnerView = UIView(frame: self.view.bounds)
            spinnerView.backgroundColor = UIColor(red: 1/255,
                                                  green: 6/255,
                                                  blue: 33/255,
                                                  alpha: 0.5)
            spinnerView.tag = 999
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.startAnimating()
            activityIndicator.color = .white
            activityIndicator.center = spinnerView.center
            spinnerView.addSubview(activityIndicator)
            self.view.addSubview(spinnerView)
            self.view.isUserInteractionEnabled = false
        }
    }
    
    func removeProgress() {
        DispatchQueue.main.async {
            if let spinnerView = self.view.subviews.first(where: { $0.tag == 999 }) {
                spinnerView.removeFromSuperview()
                self.view.isUserInteractionEnabled = true
            }
        }
    }
}

extension SpinnerDisplayable where Self: UIView {
    func showProgress() {
        DispatchQueue.main.async {
            if self.subviews.contains(where: { $0.tag == 997 }) {
                return
            }
            let spinnerView = UIView(frame: self.bounds)
            spinnerView.backgroundColor = UIColor(red: 1/255,
                                                  green: 6/255,
                                                  blue: 33/255,
                                                  alpha: 0.5)
            spinnerView.tag = 997
            spinnerView.layer.cornerRadius = 12
            spinnerView.clipsToBounds = true
            
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.startAnimating()
            activityIndicator.color = .white
            activityIndicator.center = spinnerView.center
            spinnerView.addSubview(activityIndicator)
            self.addSubview(spinnerView)
            self.isUserInteractionEnabled = false
        }
    }
    
    func removeProgress() {
        DispatchQueue.main.async {
            if let spinnerView = self.subviews.first(where: { $0.tag == 997 }) {
                spinnerView.removeFromSuperview()
                self.isUserInteractionEnabled = true
            }
        }
    }
}


