//
//  Obstacles.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 13.01.2024.
//

import Foundation

enum Obstacles: CaseIterable, Codable {
    
    case tree
    case bush
    case none
    
    var title: String {
        switch self {
        case .tree:
            return "дерево"
        case .bush:
            return "куст"
        case .none:
            return "ничего"
        }
    }
}
