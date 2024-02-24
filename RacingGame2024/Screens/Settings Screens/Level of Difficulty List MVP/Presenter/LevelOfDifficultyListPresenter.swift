//
//  LevelOfDifficultyListPresenter.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 13.01.2024.
//

import Foundation

private extension String {
    static let key = "level Of difficulty"
}

class LevelOfDifficultyListPresenter {
    
    private let settingsManager = SettingsManager()
    
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
        let savedLevelOfDifficulty = settingsManager.getLevelOfDifficulty()
        let levelOfDifficulty = levelOfDifficultyOptionItem(index: index)
        
        if savedLevelOfDifficulty.title != levelOfDifficulty.title {
            settingsManager.saveOption(option: levelOfDifficulty, key: String.key)
            delegate?.reloadData()
        }
    }
    
    func isLevelOfDifficultySelected(index: Int)-> Bool {
        let savedLevelOfDifficulty = settingsManager.getLevelOfDifficulty()
        let levelOfDifficulty = levelOfDifficultyOptionItem(index: index)
        
        if savedLevelOfDifficulty.title == levelOfDifficulty.title {
            return true
        }
        return false
    }
}
