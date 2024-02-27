//
//  ICarColorsListPresenter.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 27.02.2024.
//

import Foundation

protocol ICarColorsListPresenter {
    func setDelegate(delegate: CarColorsListPresenterDelegate) 
    func colorsCount()-> Int 
    func colorOptionItem(index: Int)-> Colors
    func selectColor(index: Int)
    func isColorSelected(index: Int)-> Bool
}
