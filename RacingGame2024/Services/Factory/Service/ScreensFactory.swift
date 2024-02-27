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
            let vc = SplashScreenViewController(animationManager: container.resolve(IAnimationManager.self)!, audioPlayerClass: container.resolve(IAudioPlayerClass.self)!, settingsManager: container.resolve(ISettingsManager.self)!)
            return vc
        case .game:
            let vc = GameViewController(accelerometerManager: container.resolve(IAccelerometerManager.self)!, audioPlayerClass: container.resolve(IAudioPlayerClass.self)!, dateManager: container.resolve(IDateManager.self)!, dataStorageManager: container.resolve(IDataStorageManager.self)!, settingsManager: container.resolve(ISettingsManager.self)!)
            return vc
        case .settingsList:
            let vc = SettingsListTableViewController(presenter: container.resolve(ISettingsListPresenter.self)!)
            return vc
        case .carColorsList:
            let vc = CarColorsListTableViewController(presenter: container.resolve(ICarColorsListPresenter.self)!)
            return vc
        case .obstaclesList:
            let vc = ObstaclesListTableViewController(presenter: container.resolve(IObstaclesListPresenter.self)!)
            return vc
        case .levelOfDifficultyList:
            let vc = LevelOfDifficultyListTableViewController(presenter: container.resolve(ILevelOfDifficultyListPresenter.self)!)
            return vc
        case .controlsList:
            let vc = ControlsListTableViewController(presenter: container.resolve(IControlsListPresenter.self)!)
            return vc
        case .records:
            let vc = RecordsListTableViewController(presenter: container.resolve(IRecordsListPresenter.self)!)
            return vc
        }
    }
}
