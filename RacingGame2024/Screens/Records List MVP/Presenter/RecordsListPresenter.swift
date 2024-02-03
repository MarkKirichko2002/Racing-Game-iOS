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
        results = dataStorageManager.loadResults().sorted { $0.score > $1.score }
        delegate?.reloadData()
    }
}
