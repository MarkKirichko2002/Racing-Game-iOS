//
//  SettingsListPresenter.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 14.01.2024.
//

import Foundation

class SettingsListPresenter {
    
    private let settingsManager = SettingsManager()
    
    weak var delegate: SettingsListPresenterDelegate?
    
    func setDelegate(delegate: SettingsListPresenterDelegate) {
        self.delegate = delegate
    }
    
    func updatePlayerInfo(name: String) {
        UserDefaults.standard.setValue(name, forKey: "player name")
        delegate?.reloadData()
    }
    
    func getInfoForOption(option: Options)-> String {
        switch option {
        case .playerInfo:
            return settingsManager.getPlayerName()
        case .carColor:
            return settingsManager.getCarColor().title
        case .obstacle:
            return settingsManager.getObstacle().title
        case .difficultyLevel:
            return settingsManager.getLevelOfDifficulty().title
        case .control:
            return settingsManager.getControl().title
        }
    }
}
