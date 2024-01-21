//
//  ObstaclesListPresenter.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 13.01.2024.
//

import Foundation

class ObstaclesListPresenter {
    
    private let settingsManager = SettingsManager()
    
    weak var delegate: ObstaclesListPresenterDelegate?
    
    func setDelegate(delegate: ObstaclesListPresenterDelegate) {
        self.delegate = delegate
    }

    func obstaclesCount()-> Int {
        return Obstacles.allCases.count
    }
    
    func obstacleOptionItem(index: Int)-> Obstacles {
        return Obstacles.allCases[index]
    }
    
    func selectObstacle(index: Int) {
        let savedObstacle = settingsManager.getObstacle()
        let obstacle = obstacleOptionItem(index: index)
        
        if savedObstacle.title != obstacle.title {
            settingsManager.saveOption(option: obstacle, key: "obstacle")
            delegate?.reloadData()
        }
    }
        
    func isObstacleSelected(index: Int)-> Bool {
        let savedObstacle = settingsManager.getObstacle()
        let obstacle = obstacleOptionItem(index: index)
        
        if savedObstacle.title == obstacle.title {
            return true
        }
        return false
    }
}
