//
//  IAccelerometerManager.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 27.02.2024.
//

import Foundation

protocol IAccelerometerManager {
    func checkAccelerometer()
    func startAccelerometerUpdates()
    func stopAccelerometerUpdates()
    func registerAccelerometerHandler(block: @escaping(Double)->Void)
}
