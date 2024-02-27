//
//  ISettingsManager.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 27.02.2024.
//

import Foundation

protocol ISettingsManager {
    func saveProfile(profile: ProfileModel)
    func getProfile()-> ProfileModel
    func getCarColor()-> Colors 
    func getObstacle()-> Obstacles
    func getLevelOfDifficulty()-> LevelOfDifficulty 
    func getControl()-> Controls
    func saveOption(option: Codable, key: String)
    func checkLevelOfDifficulty()-> Double
}
