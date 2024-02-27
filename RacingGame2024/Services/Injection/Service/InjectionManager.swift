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
            guard let settingsManager = resolver.resolve(ISettingsManager.self) else {fatalError()}
            guard let dataStorageManager = resolver.resolve(IDataStorageManager.self) else {fatalError()}
            return SettingsListPresenter(settingsManager: settingsManager, dataStorageManager: dataStorageManager)
        }
        container.register(ICarColorsListPresenter.self) { resolver in
            guard let settingsManager = resolver.resolve(ISettingsManager.self) else {fatalError()}
            return CarColorsListPresenter(settingsManager: settingsManager)
        }
        container.register(IObstaclesListPresenter.self) { resolver in
            guard let settingsManager = resolver.resolve(ISettingsManager.self) else {fatalError()}
            return ObstaclesListPresenter(settingsManager: settingsManager)
        }
        container.register(ILevelOfDifficultyListPresenter.self) { resolver in
            guard let settingsManager = resolver.resolve(ISettingsManager.self) else {fatalError()}
            return LevelOfDifficultyListPresenter(settingsManager: settingsManager)
        }
        container.register(IControlsListPresenter.self) { resolver in
            guard let settingsManager = resolver.resolve(ISettingsManager.self) else {fatalError()}
            return ControlsListPresenter(settingsManager: settingsManager)
        }
        container.register(IRecordsListPresenter.self) { resolver in
            guard let dataStorageManager = resolver.resolve(IDataStorageManager.self) else {fatalError()}
            guard let settingsManager = resolver.resolve(ISettingsManager.self) else {fatalError()}
            return RecordsListPresenter(dataStorageManager: dataStorageManager, settingsManager: settingsManager)
        }
        return container
    }
}
