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
    
    var title: String {
        switch self {
        case .red:
            return "красный"
        case .yellow:
            return "желтый"
        case .orange:
            return "оранжевый"
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
        }
    }
}
