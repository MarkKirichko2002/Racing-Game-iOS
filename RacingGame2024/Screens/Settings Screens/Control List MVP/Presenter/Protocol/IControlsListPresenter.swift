//
//  IControlsListPresenter.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 27.02.2024.
//

import Foundation

protocol IControlsListPresenter {
    func setDelegate(delegate: ControlsListPresenterDelegate)
    func controlsCount()-> Int
    func controlOptionItem(index: Int)-> Controls 
    func selectControl(index: Int)
    func isControlSelected(index: Int)-> Bool
}
