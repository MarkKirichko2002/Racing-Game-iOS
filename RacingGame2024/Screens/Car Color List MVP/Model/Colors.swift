//
//  Colors.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 13.01.2024.
//

import UIKit

enum Colors: CaseIterable, Codable {
    
    case red
    case yellow
    case orange
    case blue
    case green
    
    var title: String {
        switch self {
        case .red:
            return "красный"
        case .yellow:
            return "желтый"
        case .orange:
            return "оранжевый"
        case .blue:
            return "синий"
        case .green:
            return "зеленый"
        }
    }
    
    var color: UIColor {
        switch self {
        case .red:
            return UIColor.systemRed
        case .yellow:
            return UIColor.systemYellow
        case .orange:
            return UIColor.systemOrange
        case .blue:
            return UIColor.systemBlue
        case .green:
            return UIColor.systemGreen
        }
    }
}
