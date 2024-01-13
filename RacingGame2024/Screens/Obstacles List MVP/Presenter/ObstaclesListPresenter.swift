//
//  ObstaclesListPresenter.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 13.01.2024.
//

import Foundation

class ObstaclesListPresenter {
    
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
        let savedObstacle = UserDefaults.loadData(type: Obstacles.self, key: "obstacle") ?? Obstacles.tree
        let obstacle = obstacleOptionItem(index: index)
        
        if savedObstacle.title != obstacle.title {
            saveObstacle(obstacle: obstacle)
            delegate?.reloadData()
        }
    }
    
    func saveObstacle(obstacle: Obstacles) {
        UserDefaults.saveData(object: obstacle, key: "obstacle") {
            print("Препятствие сохранено!")
        }
    }
    
    func isObstacleSelected(index: Int)-> Bool {
        let savedObstacle = UserDefaults.loadData(type: Obstacles.self, key: "obstacle") ?? Obstacles.tree
        let obstacle = obstacleOptionItem(index: index)
        
        if savedObstacle.title == obstacle.title {
            return true
        }
        return false
    }
}
