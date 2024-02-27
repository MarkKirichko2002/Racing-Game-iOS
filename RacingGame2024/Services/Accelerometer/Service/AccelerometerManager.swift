//
//  GyroscopeManager.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 17.01.2024.
//

import CoreMotion

private extension TimeInterval {
    static let accelerometerUpdateInterval = 1.0 / 10.0
}

private extension String {
    static let message = "нет акселерометр"
}

final class AccelerometerManager: IAccelerometerManager {
    
    private let manager = CMMotionManager()
    
    private var accelerometerHandler: ((Double)->Void)?
    
    func checkAccelerometer() {
        if manager.isGyroAvailable {
            startAccelerometerUpdates()
        } else {
            print(String.message)
        }
    }
    
    func startAccelerometerUpdates() {
        
        manager.accelerometerUpdateInterval = TimeInterval.accelerometerUpdateInterval
        
        manager.startAccelerometerUpdates(to: OperationQueue.current!) { [weak self] accelerometerData, error in
            if let acceleration = accelerometerData?.acceleration {
                let xAcceleration = acceleration.x
                self?.accelerometerHandler?(xAcceleration)
            }
        }
    }
    
    func stopAccelerometerUpdates() {
        manager.stopAccelerometerUpdates()
    }
    
    func registerAccelerometerHandler(block: @escaping(Double)->Void) {
        self.accelerometerHandler = block
    }
}
