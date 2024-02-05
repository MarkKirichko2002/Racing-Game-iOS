//
//  SettingsManager.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 14.01.2024.
//

import Foundation

class SettingsManager {
    
    func saveProfile(profile: ProfileModel) {
        UserDefaults.saveData(object: profile, key: "profile") {}
    }
    
    func getProfile()-> ProfileModel {
        let player = UserDefaults.loadData(type: ProfileModel.self, key: "profile") ?? ProfileModel(playerName: "Игрок", image: nil)
        return player
    }
    
    func getCarColor()-> Colors {
        let color = UserDefaults.loadData(type: Colors.self, key: "car color") ?? Colors.red
        return color
    }
    
    func getObstacle()-> Obstacles {
        let obstacle = UserDefaults.loadData(type: Obstacles.self, key: "obstacle") ?? Obstacles.tree
        return obstacle
    }
    
    func getLevelOfDifficulty()-> LevelOfDifficulty {
        let levelOfDifficulty = UserDefaults.loadData(type: LevelOfDifficulty.self, key: "level Of difficulty") ?? LevelOfDifficulty.easy
        return levelOfDifficulty
    }
    
    func getControl()-> Controls {
        let control = UserDefaults.loadData(type: Controls.self, key: "control") ?? Controls.tap
        return control
    }
    
    func saveOption(option: Codable, key: String) {
        UserDefaults.saveData(object: option, key: key) {
            print("опция сохранена!")
        }
    }
    
    func checkLevelOfDifficulty()-> Double {
        let level = getLevelOfDifficulty()
        switch level {
        case .easy:
            return 8
        case .normal:
            return 15
        case .hard:
            return 20
        }
    }
}
