//
//  ResultModel.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 22.01.2024.
//

import Foundation

struct ResultModel: Codable {
    let playerName: String
    let image: Data
    let score: Int
    let date: String
    let time: String
}
