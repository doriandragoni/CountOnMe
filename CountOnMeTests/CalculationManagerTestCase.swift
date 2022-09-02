//
//  CalculationManagerTestCase.swift
//  CountOnMeTests
//
//  Created by Dorian Dragoni on 02/09/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculationManagerTestCase: XCTestCase {
    var calculationManager: CalculationManager!

    override func setUp() {
        super.setUp()
        calculationManager = CalculationManager()
    }
}
