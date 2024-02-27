//
//  RecordsListPresenter.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 22.01.2024.
//

import Foundation

final class RecordsListPresenter: IRecordsListPresenter {
    
    weak var delegate: RecordsListPresenterDelegate?
    var results = [ResultModel]()
    
    private var dataStorageManager: IDataStorageManager
    private var settingsManager: ISettingsManager
    
    init(dataStorageManager: IDataStorageManager, settingsManager: ISettingsManager) {
        self.dataStorageManager = dataStorageManager
        self.settingsManager = settingsManager
    }
    
    func setDelegate(delegate: RecordsListPresenterDelegate) {
        self.delegate = delegate
    }
    
    func getResults() {
        results = dataStorageManager.loadResults().sorted { $0.score > $1.score }
        delegate?.reloadData()
    }
    
    func deleteResult(result: ResultModel) {
        dataStorageManager.deleteResult(result: result)
        getResults()
    }
}
