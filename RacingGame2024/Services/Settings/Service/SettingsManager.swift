//
//  SettingsManager.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 14.01.2024.
//

import Foundation

private extension String {
    static let defaultName = "Игрок"
    static let keyProfile = "profile"
    static let keyCarColor = "car color"
    static let keyObstacle = "obstacle"
    static let keyLevelOfDifficulty = "level Of difficulty"
    static let keyControl = "control"
}

private extension Double {
    static let easy = 8.0
    static let normal = 15.0
    static let hard = 20.0
}

final class SettingsManager: ISettingsManager {
    
    func saveProfile(profile: ProfileModel) {
        UserDefaults.saveData(object: profile, key: String.keyProfile) {}
    }
    
    func getProfile()-> ProfileModel {
        let player = UserDefaults.loadData(type: ProfileModel.self, key: String.keyProfile) ?? ProfileModel(playerName: String.defaultName, image: nil)
        return player
    }
    
    func getCarColor()-> Colors {
        let color = UserDefaults.loadData(type: Colors.self, key: String.keyCarColor) ?? Colors.red
        return color
    }
    
    func getObstacle()-> Obstacles {
        let obstacle = UserDefaults.loadData(type: Obstacles.self, key: String.keyObstacle) ?? Obstacles.tree
        return obstacle
    }
    
    func getLevelOfDifficulty()-> LevelOfDifficulty {
        let levelOfDifficulty = UserDefaults.loadData(type: LevelOfDifficulty.self, key: String.keyLevelOfDifficulty) ?? LevelOfDifficulty.easy
        return levelOfDifficulty
    }
    
    func getControl()-> Controls {
        let control = UserDefaults.loadData(type: Controls.self, key: String.keyControl) ?? Controls.tap
        return control
    }
    
    func saveOption(option: Codable, key: String) {
        UserDefaults.saveData(object: option, key: key) {}
    }
    
    func checkLevelOfDifficulty()-> Double {
        let level = getLevelOfDifficulty()
        switch level {
        case .easy:
            return Double.easy
        case .normal:
            return Double.normal
        case .hard:
            return Double.hard
        }
    }
}
