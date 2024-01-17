//
//  GameObject.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 16.01.2024.
//

import UIKit

class GameObject: Equatable {
    var view: UIImageView
    var speed: CGFloat
    
    init() {
        let squareSize: CGFloat = 70.0
        let screenWidth = UIScreen.main.bounds.width
        
        // Создаем UIView для представления квадрата
        view = UIImageView(frame: CGRect(x: CGFloat.random(in: 0...(screenWidth - squareSize)), y: 0, width: squareSize, height: squareSize))
        
        // Задаем случайную скорость для квадрата
        speed = 15
    }
    
    static func ==(lhs: GameObject, rhs: GameObject) -> Bool {
        return lhs.view == rhs.view
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(view)
    }
}
