//
//  AnimationManager.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 14.01.2024.
//

import UIKit

class AnimationManager {
    
    func springView(view: UIView) {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 250
        animation.mass = 1
        animation.duration = 0.5
        animation.beginTime = CACurrentMediaTime() + 0
        view.layer.add(animation, forKey: nil)
    }
}
