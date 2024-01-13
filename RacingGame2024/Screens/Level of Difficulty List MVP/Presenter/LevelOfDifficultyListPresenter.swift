//
//  LevelOfDifficultyListPresenter.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 13.01.2024.
//

import Foundation

class LevelOfDifficultyListPresenter {
    
    weak var delegate: LevelOfDifficultyListPresenterDelegate?
    
    func setDelegate(delegate: LevelOfDifficultyListPresenterDelegate) {
        self.delegate = delegate
    }

    func levelOfDifficultyCount()-> Int {
        return LevelOfDifficulty.allCases.count
    }
    
    func levelOfDifficultyOptionItem(index: Int)-> LevelOfDifficulty {
        return LevelOfDifficulty.allCases[index]
    }
    
    func selectlevelOfDifficulty(index: Int) {
        let savedLevelOfDifficulty = UserDefaults.loadData(type: LevelOfDifficulty.self, key: "level Of difficulty") ?? LevelOfDifficulty.easy
        let levelOfDifficulty = levelOfDifficultyOptionItem(index: index)
        
        if savedLevelOfDifficulty.title != levelOfDifficulty.title {
            saveLevelOfDifficulty(level: levelOfDifficulty)
            delegate?.reloadData()
        }
    }
    
    func saveLevelOfDifficulty(level: LevelOfDifficulty) {
        UserDefaults.saveData(object: level, key: "level Of difficulty") {
            print("Уровень сложности сохранен!")
        }
    }
    
    func isLevelOfDifficultySelected(index: Int)-> Bool {
        let savedLevelOfDifficulty = UserDefaults.loadData(type: LevelOfDifficulty.self, key: "level Of difficulty") ?? LevelOfDifficulty.easy
        let levelOfDifficulty = levelOfDifficultyOptionItem(index: index)
        
        if savedLevelOfDifficulty.title == levelOfDifficulty.title {
            return true
        }
        return false
    }
}
