//
//  IObstaclesListPresenter.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 27.02.2024.
//

import Foundation

protocol IObstaclesListPresenter {
    func setDelegate(delegate: ObstaclesListPresenterDelegate)
    func obstaclesCount()-> Int 
    func obstacleOptionItem(index: Int)-> Obstacles
    func selectObstacle(index: Int) 
    func isObstacleSelected(index: Int)-> Bool
}
