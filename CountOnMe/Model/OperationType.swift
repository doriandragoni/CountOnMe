//
//  OperationType.swift
//  CountOnMe
//
//  Created by Dorian Dragoni on 26/09/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

enum OperationType: String {
    case addition = "+", substraction = "-", multiplication = "x", division = "/"

    static func isOperationType(_ element: String) -> Bool {
        return OperationType(rawValue: element) != nil
    }
}
