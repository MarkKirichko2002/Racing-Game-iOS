//
//  IRecordsListPresenter.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 27.02.2024.
//

import Foundation

protocol IRecordsListPresenter {
    var results: [ResultModel] {get set}
    func setDelegate(delegate: RecordsListPresenterDelegate)
    func getResults()
    func deleteResult(result: ResultModel)
}
