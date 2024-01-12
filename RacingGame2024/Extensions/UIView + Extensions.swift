//
//  UIView + Extensions.swift
//  RacingGame
//
//  Created by Марк Киричко on 11.01.2024.
//

import UIKit

extension UIView {
    func addSubviews(views: UIView...) {
        views.forEach { addSubview($0)}
    }
}

