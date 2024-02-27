//
//  IDataStorageManager.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 27.02.2024.
//

import UIKit

protocol IDataStorageManager {
    func saveFileURL(url: String) 
    func getFileURL()-> String
    func saveImage(_ image: UIImage) throws -> String?
    func loadImage(from fileName: String)-> Data?
    func loadResults()-> [ResultModel] 
    func saveResult(result: ResultModel)
    func deleteResult(result: ResultModel)
    func saveArray(array: [ResultModel])
}
