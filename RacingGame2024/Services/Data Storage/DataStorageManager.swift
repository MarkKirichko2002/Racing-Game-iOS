//
//  DataStorageManager.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 22.01.2024.
//

import Foundation

class DataStorageManager {
    
    func saveResult(result: ResultModel) {
        UserDefaults.saveData(object: result, key: "result") {
            print("результат сохранен")
        }
    }
    
    func getResult()-> ResultModel {
        let result = UserDefaults.loadData(type: ResultModel.self, key: "result") ?? ResultModel(playerName: "Гонщик", image: Data(), score: 0, date: "-", time: "-")
        return result
    }
}
