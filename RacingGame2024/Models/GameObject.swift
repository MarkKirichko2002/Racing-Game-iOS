//
//  GameObject.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 16.01.2024.
//

import UIKit

private extension CGFloat {
    static let number = 0.0
    static let squareSize = 70.0
    static let speed = 10.0
}

class GameObject: Equatable {
    
    var view: UIImageView
    var speed: CGFloat
    
    init() {
        let squareSize = CGFloat.squareSize
        let screenWidth = UIScreen.main.bounds.width
        
        view = UIImageView(frame: CGRect(x: CGFloat.random(in: CGFloat.number...(screenWidth - squareSize)), y: CGFloat.number, width: squareSize, height: squareSize))
        
        speed = CGFloat.speed
    }
    
    static func ==(lhs: GameObject, rhs: GameObject) -> Bool {
        return lhs.view == rhs.view
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(view)
    }
}
