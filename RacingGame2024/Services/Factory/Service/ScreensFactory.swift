//
//  ScreensFactory.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 27.02.2024.
//

import UIKit

enum Screens {
    case splash
    case game
    case settingsList
    case carColorsList
    case obstaclesList
    case levelOfDifficultyList
    case controlsList
    case records
}

final class ScreensFactory {
    
    static func createScreen(screen: Screens)-> UIViewController {
        let container = InjectionManager.makeContainer()
        switch screen {
        case .splash:
            guard let animationManager = container.resolve(IAnimationManager.self) else {fatalError()}
            guard let audioPlayerClass = container.resolve(IAudioPlayerClass.self) else {fatalError()}
            guard let settingsManager = container.resolve(ISettingsManager.self) else {fatalError()}
            let vc = SplashScreenViewController(animationManager: animationManager, audioPlayerClass: audioPlayerClass, settingsManager: settingsManager)
            return vc
        case .game:
            guard let accelerometerManager = container.resolve(IAccelerometerManager.self) else {fatalError()}
            guard let audioPlayerClass = container.resolve(IAudioPlayerClass.self) else {fatalError()}
            guard let dateManager = container.resolve(IDateManager.self) else {fatalError()}
            guard let dataStorageManager = container.resolve(IDataStorageManager.self) else {fatalError()}
            guard let settingsManager = container.resolve(ISettingsManager.self) else {fatalError()}
            let vc = GameViewController(accelerometerManager: accelerometerManager, audioPlayerClass: audioPlayerClass, dateManager: dateManager, dataStorageManager: dataStorageManager, settingsManager: settingsManager)
            return vc
        case .settingsList:
            guard let presenter = container.resolve(ISettingsListPresenter.self) else {fatalError()}
            let vc = SettingsListTableViewController(presenter: presenter)
            return vc
        case .carColorsList:
            guard let presenter = container.resolve(ICarColorsListPresenter.self) else {fatalError()}
            let vc = CarColorsListTableViewController(presenter: presenter)
            return vc
        case .obstaclesList:
            guard let presenter = container.resolve(IObstaclesListPresenter.self) else {fatalError()}
            let vc = ObstaclesListTableViewController(presenter: presenter)
            return vc
        case .levelOfDifficultyList:
            guard let presenter = container.resolve(ILevelOfDifficultyListPresenter.self) else {fatalError()}
            let vc = LevelOfDifficultyListTableViewController(presenter: presenter)
            return vc
        case .controlsList:
            guard let presenter = container.resolve(IControlsListPresenter.self) else {fatalError()}
            let vc = ControlsListTableViewController(presenter: presenter)
            return vc
        case .records:
            guard let presenter = container.resolve(IRecordsListPresenter.self) else {fatalError()}
            let vc = RecordsListTableViewController(presenter: presenter)
            return vc
        }
    }
}
