//
//  ISettingsListPresenter.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 27.02.2024.
//

import UIKit

protocol ISettingsListPresenter {
    func setDelegate(delegate: SettingsListPresenterDelegate)
    func getProfileName()-> String 
    func updatePlayerButtonTapped(name: String) 
    func savePhotoButtonTapped(image: UIImage)
    func getInfoForOption(option: Options)-> String
    func getProfileInfo()-> ProfileModel
}
