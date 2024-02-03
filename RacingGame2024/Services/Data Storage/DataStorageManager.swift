//
//  DataStorageManager.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 22.01.2024.
//

import Foundation

class DataStorageManager {
    
    func loadResults()-> [ResultModel] {
        var data = [ResultModel]()
        if let result = UserDefaults.standard.object(forKey: "results") as? Data {
            do {
                data = try JSONDecoder().decode([ResultModel].self, from: result)
            } catch {
                print(error)
            }
        }
        return data
    }
    
    func saveResults(result: ResultModel) {
        var array = loadResults()
        if let index = array.firstIndex(where: { $0.playerName == result.playerName && $0.score < result.score }) {
            array.remove(at: index)
            array.append(result)
        } else {
            array.append(result)
        }
        do {
            let arr = try JSONEncoder().encode(array)
            UserDefaults.standard.setValue(arr, forKey: "results")
        } catch {
            print(error)
        }
    }
}
