//
//  LevelOfDifficulty.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 13.01.2024.
//

import Foundation

enum LevelOfDifficulty: CaseIterable, Codable {
    case easy
    case normal
    case hard
    
    var title: String {
        switch self {
        case .easy:
            return "легко"
        case .normal:
            return "нормально"
        case .hard:
            return "сложно"
        }
    }
}
