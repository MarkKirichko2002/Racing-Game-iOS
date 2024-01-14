//
//  CarColorsListPresenter.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 13.01.2024.
//

import UIKit

class CarColorsListPresenter {
    
    private let settingsManager = SettingsManager()
    
    weak var delegate: CarColorsListPresenterDelegate?
    
    func setDelegate(delegate: CarColorsListPresenterDelegate) {
        self.delegate = delegate
    }

    func colorsCount()-> Int {
        return Colors.allCases.count
    }
    
    func colorOptionItem(index: Int)-> Colors {
        return Colors.allCases[index]
    }
    
    func selectColor(index: Int) {
        let savedColor = settingsManager.getCarColor()
        let color = colorOptionItem(index: index)
        
        if savedColor.color != color.color {
            settingsManager.saveOption(option: color, key: "car color")
            delegate?.reloadData()
        }
    }
    
    func isColorSelected(index: Int)-> Bool {
        let savedColor = settingsManager.getCarColor()
        let color = colorOptionItem(index: index)
        
        if savedColor.color == color.color {
            return true
        }
        return false
    }
}
