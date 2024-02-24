//
//  DateManager.swift
//  RacingGame
//
//  Created by Марк Киричко on 12.01.2024.
//

import Foundation

private extension String {
    static let dateFormat = "dd.MM.yyyy"
    static let hourFormat = "HH:mm"
}

class DateManager {
    
    private let formatter = DateFormatter()
    
    func getCurrentDate()-> String {
        let date = Date()
        formatter.dateFormat = String.dateFormat
        return formatter.string(from: date)
    }
    
    func getCurrentTime()-> String {
        let date = Date()
        formatter.dateFormat = String.hourFormat
        return formatter.string(from: date)
    }
}
