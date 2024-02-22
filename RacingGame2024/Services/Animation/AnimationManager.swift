//
//  AnimationManager.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 14.01.2024.
//

import UIKit

private extension String {
    static let keyPath = "transform.scale"
}

private extension Int {
    static let fromValue = 0
    static let toValue = 1
    static let duration = 0.5
    static let beginTime = CACurrentMediaTime() + 0
}

private extension CGFloat {
    static let stiffness = 250.0
    static let mas = 1.0
}

class AnimationManager {
    
    func springView(view: UIView) {
        let animation = CASpringAnimation(keyPath: String.keyPath)
        animation.fromValue = Int.fromValue
        animation.toValue = Int.toValue
        animation.stiffness = CGFloat.stiffness
        animation.mass = CGFloat.mas
        animation.duration = Int.duration
        animation.beginTime = Int.beginTime
        view.layer.add(animation, forKey: nil)
    }
}
