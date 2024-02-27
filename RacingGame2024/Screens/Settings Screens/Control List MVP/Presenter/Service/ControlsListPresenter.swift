//
//  ControlsListPresenter.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 13.01.2024.
//

import Foundation

private extension String {
    static let key = "control"
}

final class ControlsListPresenter: IControlsListPresenter {
    
    private let settingsManager: ISettingsManager
    
    weak var delegate: ControlsListPresenterDelegate?
    
    init(settingsManager: ISettingsManager) {
        self.settingsManager = settingsManager
    }
    
    func setDelegate(delegate: ControlsListPresenterDelegate) {
        self.delegate = delegate
    }
    
    func controlsCount()-> Int {
        return Controls.allCases.count
    }
    
    func controlOptionItem(index: Int)-> Controls {
        return Controls.allCases[index]
    }
    
    func selectControl(index: Int) {
        let savedControl = settingsManager.getControl()
        let control = controlOptionItem(index: index)
        
        if savedControl.title != control.title {
            settingsManager.saveOption(option: control, key: String.key)
            delegate?.reloadData()
        }
    }
    
    func isControlSelected(index: Int)-> Bool {
        let savedControl = settingsManager.getControl()
        let control = controlOptionItem(index: index)
        
        if savedControl.title == control.title {
            return true
        }
        return false
    }
}
