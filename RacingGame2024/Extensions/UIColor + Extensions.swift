//
//  UIColor + Extensions.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 13.01.2024.
//

import UIKit

extension UIColor: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        let components = self.cgColor.components
        
        try container.encode(components)
    }
}
