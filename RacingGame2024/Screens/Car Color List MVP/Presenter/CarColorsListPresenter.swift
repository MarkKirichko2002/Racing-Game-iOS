//
//  CarColorsListPresenter.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 13.01.2024.
//

import UIKit

class CarColorsListPresenter {
    
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
        let savedColor = UserDefaults.loadData(type: Colors.self, key: "car color") ?? Colors.red
        let color = colorOptionItem(index: index)
        
        if savedColor.color != color.color {
            saveColor(color: color)
            delegate?.reloadData()
        }
    }
    
    func saveColor(color: Colors) {
        UserDefaults.saveData(object: color, key: "car color") {
            print("цвет машины сохранен!")
        }
    }
    
    func isColorSelected(index: Int)-> Bool {
        let savedColor = UserDefaults.loadData(type: Colors.self, key: "car color") ?? Colors.red
        let color = colorOptionItem(index: index)
        
        if savedColor.color == color.color {
            return true
        }
        return false
    }
}
