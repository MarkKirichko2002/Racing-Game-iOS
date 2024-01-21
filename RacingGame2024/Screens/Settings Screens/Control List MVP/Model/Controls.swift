//
//  Controls.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 13.01.2024.
//

import Foundation

enum Controls: CaseIterable, Codable {
    case tap
    case swipe
    case accelerometer
    
    var title: String {
        switch self {
        case .tap:
            return "нажатие"
        case .swipe:
            return "свайп"
        case .accelerometer:
            return "акселерометр"
        }
    }
}
