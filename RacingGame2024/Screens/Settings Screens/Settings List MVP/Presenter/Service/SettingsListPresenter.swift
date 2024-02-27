//
//  SettingsListPresenter.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 14.01.2024.
//

import UIKit

final class SettingsListPresenter: ISettingsListPresenter {
    
    private var settingsManager: ISettingsManager
    private var dataStorageManager: IDataStorageManager
    
    weak var delegate: SettingsListPresenterDelegate?
    
    init(settingsManager: ISettingsManager, dataStorageManager: IDataStorageManager) {
        self.settingsManager = settingsManager
        self.dataStorageManager = dataStorageManager
    }
    
    func setDelegate(delegate: SettingsListPresenterDelegate) {
        self.delegate = delegate
    }
    
    func getProfileName()-> String {
        let profile = settingsManager.getProfile()
        return profile.playerName
    }
    
    func updatePlayerButtonTapped(name: String) {
        var profile = settingsManager.getProfile()
        profile.playerName = name
        settingsManager.saveProfile(profile: profile)
        delegate?.reloadData()
    }
    
    func savePhotoButtonTapped(image: UIImage) {
        var profile = settingsManager.getProfile()
        if let fileURL = try? dataStorageManager.saveImage(image) {
            dataStorageManager.saveFileURL(url: fileURL)
        }
        let image = dataStorageManager.loadImage(from: dataStorageManager.getFileURL())
        profile.image = image
        settingsManager.saveProfile(profile: profile)
        delegate?.reloadData()
    }
    
    func getInfoForOption(option: Options)-> String {
        switch option {
        case .playerInfo:
            return settingsManager.getProfile().playerName
        case .carColor:
            return settingsManager.getCarColor().title
        case .obstacle:
            return settingsManager.getObstacle().title
        case .difficultyLevel:
            return settingsManager.getLevelOfDifficulty().title
        case .control:
            return settingsManager.getControl().title
        }
    }
    
    func getProfileInfo()-> ProfileModel {
        let profile = settingsManager.getProfile()
        return profile
    }
}
