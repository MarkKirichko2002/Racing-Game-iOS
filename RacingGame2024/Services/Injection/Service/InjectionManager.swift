//
//  InjectionManager.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 27.02.2024.
//

import Swinject

final class InjectionManager {
    
    static func makeContainer()-> Container {
        let container = Container()
        // MARK: - Services
        container.register(IAccelerometerManager.self) { _ in
            return AccelerometerManager()
        }
        container.register(IAnimationManager.self) { _ in
            return AnimationManager()
        }
        container.register(IAudioPlayerClass.self) { _ in
            return AudioPlayerClass()
        }
        container.register(IDateManager.self) { _ in
            return DateManager()
        }
        container.register(IDataStorageManager.self) { _ in
            return DataStorageManager()
        }
        container.register(ISettingsManager.self) { _ in
            return SettingsManager()
        }
        // MARK: - Presenters
        container.register(ISettingsListPresenter.self) { resolver in
            return SettingsListPresenter(settingsManager: resolver.resolve(ISettingsManager.self)!, dataStorageManager: resolver.resolve(IDataStorageManager.self)!)
        }
        container.register(ICarColorsListPresenter.self) { resolver in
            return CarColorsListPresenter(settingsManager: resolver.resolve(ISettingsManager.self)!)
        }
        container.register(IObstaclesListPresenter.self) { resolver in
            return ObstaclesListPresenter(settingsManager: resolver.resolve(ISettingsManager.self)!)
        }
        container.register(ILevelOfDifficultyListPresenter.self) { resolver in
            return LevelOfDifficultyListPresenter(settingsManager: resolver.resolve(ISettingsManager.self)!)
        }
        container.register(IControlsListPresenter.self) { resolver in
            return ControlsListPresenter(settingsManager: resolver.resolve(ISettingsManager.self)!)
        }
        container.register(IRecordsListPresenter.self) { resolver in
            return RecordsListPresenter(dataStorageManager: resolver.resolve(IDataStorageManager.self)!, settingsManager: resolver.resolve(ISettingsManager.self)!)
        }
        return container
    }
}
