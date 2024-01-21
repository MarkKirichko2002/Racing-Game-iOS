//
//  Obstacles.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 13.01.2024.
//

import Foundation

enum Obstacles: CaseIterable, Codable {
    
    case tree
    case palm
    case bush
    case moose
    case cyclist
    case none
    
    var title: String {
        switch self {
        case .tree:
            return "дерево"
        case .palm:
            return "пальма"
        case .bush:
            return "куст"
        case .moose:
            return "лось"
        case .cyclist:
            return "велосипедист"
        case .none:
            return "ничего"
        }
    }
    
    var image: String {
        switch self {
        case .tree:
            return "tree"
        case .palm:
            return "palm"
        case .bush:
            return "bush"
        case .moose:
            return "moose"
        case .cyclist:
            return "cyclist"
        case .none:
            return ""
        }
    }
}
