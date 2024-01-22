//
//  RecordsListPresenter.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 22.01.2024.
//

import Foundation

class RecordsListPresenter {
    
    weak var delegate: RecordsListPresenterDelegate?
    
    private let dataStorageManager = DataStorageManager()
    
    var results = [ResultModel]()
    
    func setDelegate(delegate: RecordsListPresenterDelegate) {
        self.delegate = delegate
    }
    
    func getResults() {
        let result = dataStorageManager.getResult()
        results.append(result)
        delegate?.reloadData()
    }
}
