//
//  GradientSettingsModel.swift
//  GameVerseApp
//
//  Created by beyyzgur on 10.02.2026.
//

import UIKit

struct GradientSettingsModel {
    let startColor: UIColor
    let midColor: UIColor?
    let endColor: UIColor
    let startPoint: CGPoint
    let endPoint: CGPoint
    let locations: [NSNumber]?
    
    init(startColor: UIColor,
         midColor: UIColor? = nil,
         endColor: UIColor,
         startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0),
         endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0),
         locations: [NSNumber]) {
        self.startColor = startColor
        self.midColor = midColor
        self.endColor = endColor
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.locations = locations
    }
}
