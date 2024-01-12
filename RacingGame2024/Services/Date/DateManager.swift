//
//  DateManager.swift
//  RacingGame
//
//  Created by Марк Киричко on 12.01.2024.
//

import Foundation

class DateManager {
    
    private let formatter = DateFormatter()
    
    func getCurrentDate()-> String {
        let date = Date()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    func getCurrentTime()-> String {
        let date = Date()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
