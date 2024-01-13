//
//  ControlsListPresenter.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 13.01.2024.
//

import Foundation

class ControlsListPresenter {
    
    weak var delegate: ControlsListPresenterDelegate?
    
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
        let savedControl = UserDefaults.loadData(type: Controls.self, key: "control") ?? Controls.tap
        let control = controlOptionItem(index: index)
        
        if savedControl.title != control.title {
            saveControl(control: control)
            delegate?.reloadData()
        }
    }
    
    func saveControl(control: Controls) {
        UserDefaults.saveData(object: control, key: "control") {
            print("Управление сохранено!")
        }
    }
    
    func isControlSelected(index: Int)-> Bool {
        let savedControl = UserDefaults.loadData(type: Controls.self, key: "control") ?? Controls.tap
        let control = controlOptionItem(index: index)
        
        if savedControl.title == control.title {
            return true
        }
        return false
    }
}
