//
//  DataStorageManager.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 22.01.2024.
//

import UIKit

class DataStorageManager {
    
    func saveFileURL(url: String) {
        UserDefaults.standard.setValue(url, forKey: "fileURL")
    }
    
    func getFileURL()-> String {
        let url = UserDefaults.standard.string(forKey: "fileURL") ?? ""
        return url
    }
    
    func saveImage(_ image: UIImage) throws -> String? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let name = UUID().uuidString
        let fileURL = directory.appendingPathComponent(name, conformingTo: .fileURL)
        
        guard let data = image.jpegData(compressionQuality: 1.0) else {return nil}
        try data.write(to: fileURL)
        
        return name
    }
    
    func loadImage(from fileName: String)-> Data? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let fileURL = directory.appendingPathComponent(fileName, conformingTo: .fileURL)
        do {
            let data = try Data(contentsOf: fileURL)
            return data
        } catch {
            print(error)
        }
        return nil
    }
    
    
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
    
    func saveResult(result: ResultModel) {
        
        var array = loadResults()
        
        if let index = array.firstIndex(where: { $0.playerName == result.playerName && ($0.score <= result.score || $0.score >= result.score)}) {
            array.remove(at: index)
            array.append(result)
        } else {
            array.append(result)
        }
        saveArray(array: array)
    }
    
    func deleteResult(result: ResultModel) {
        
        var array = loadResults()
        
        if let index = array.firstIndex(where: { $0.playerName == result.playerName }) {
            array.remove(at: index)
        }
        saveArray(array: array)
    }
    
    private func saveArray(array: [ResultModel]) {
        do {
            let arr = try JSONEncoder().encode(array)
            UserDefaults.standard.setValue(arr, forKey: "results")
        } catch {
            print(error)
        }
    }
}
