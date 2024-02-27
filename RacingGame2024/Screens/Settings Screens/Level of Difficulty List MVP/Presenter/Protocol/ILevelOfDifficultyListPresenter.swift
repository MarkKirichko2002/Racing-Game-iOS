//
//  ILevelOfDifficultyListPresenter.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 27.02.2024.
//

import Foundation

protocol ILevelOfDifficultyListPresenter {
    func setDelegate(delegate: LevelOfDifficultyListPresenterDelegate)
    func levelOfDifficultyCount()-> Int 
    func levelOfDifficultyOptionItem(index: Int)-> LevelOfDifficulty 
    func selectlevelOfDifficulty(index: Int)
    func isLevelOfDifficultySelected(index: Int)-> Bool
}
