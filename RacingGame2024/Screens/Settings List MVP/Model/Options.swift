//
//  Options.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 12.01.2024.
//

import Foundation

enum Options: CaseIterable {
    
    case playerInfo
    case carColor
    case obstacle
    case difficultyLevel
    case control
    
    var title: String {
        switch self {
        case .playerInfo:
            return "Игрок"
        case .carColor:
            return "Цвет Машины"
        case .obstacle:
            return "Препятствия"
        case .difficultyLevel:
            return "Уровень сложности"
        case .control:
            return "Управление"
        }
    }
    
    var icon: String {
        switch self {
        case .playerInfo:
            return "racer"
        case .carColor:
            return "car red"
        case .obstacle:
            return "obstacle"
        case .difficultyLevel:
            return "difficulty level"
        case .control:
            return "control"
        }
    }
}
