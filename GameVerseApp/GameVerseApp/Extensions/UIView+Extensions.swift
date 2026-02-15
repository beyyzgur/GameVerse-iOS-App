//
//  UIView+Extensions.swift
//  GameVerseApp
//
//  Created by beyyzgur on 10.02.2026.
//

import UIKit

extension UIView {
    private var gradientLayerName: String { "customGradientLayer" }
    func applyGradient(with settings: GradientSettingsModel) {
        var colors: [CGColor] = [settings.startColor.cgColor]
        if let mid = settings.midColor {
            colors.append(mid.cgColor)
        }
        colors.append(settings.endColor.cgColor)
        
        let existingLayer = layer.sublayers?.first(where: { $0.name == gradientLayerName }) as? CAGradientLayer
        let gradient: CAGradientLayer
        
        if let existing = existingLayer {
            gradient = existing
        } else {
            gradient = CAGradientLayer()
            gradient.name = gradientLayerName
            layer.insertSublayer(gradient, at: 0)
        }
        
        gradient.frame = bounds
        gradient.colors = colors
        gradient.startPoint = settings.startPoint
        gradient.endPoint = settings.endPoint
        gradient.locations = settings.locations
    }
}
