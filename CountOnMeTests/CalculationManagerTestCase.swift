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

    func testGivenNewCalculation_WhenAddingNumber_ThenNumberAdded() {
        calculationManager.addNumber("3")

        XCTAssertEqual(calculationManager.elements.last, "3")
        XCTAssertTrue(calculationManager.canAddOperator)
    }

    func testGivenNumberAdded_WhenAddingNumber_ThenNumberAppendedToTheLastNumber() {
        calculationManager.addNumber("3")

        calculationManager.addNumber("4")

        XCTAssertEqual(calculationManager.elements.last, "34")
    }

    func testGivenExpressionHaveResult_WhenAddingNumber_ThenClearElementsAndStartNewCalculation() {
        calculationManager.addNumber("3")
        calculationManager.addOperator(.addition)
        calculationManager.addNumber("4")
        calculationManager.getResult()

        calculationManager.addNumber("6")

        XCTAssertEqual(calculationManager.elements, ["6"])
    }

    func testGivenNumberAdded_WhenAddingOperator_ThenOperatorAdded() {
        calculationManager.addNumber("3")
        calculationManager.addOperator(.addition)

        XCTAssertEqual(calculationManager.elements.last, "+")
        XCTAssertFalse(calculationManager.canAddOperator)
    }

    func testGivenNumberAndOperatorAdded_WhenAddingNumber_ThenExpressionIsCorrectAndHaveEnoughElements() {
        calculationManager.addNumber("3")
        calculationManager.addOperator(.addition)

        calculationManager.addNumber("4")

        XCTAssertTrue(calculationManager.expressionIsCorrect)
        XCTAssertTrue(calculationManager.expressionHaveEnoughElement)
    }

    func testGivenExpression3Plus4_WhenGettingResult_ThenResultIs7() {
        calculationManager.addNumber("3")
        calculationManager.addOperator(.addition)
        calculationManager.addNumber("4")

        calculationManager.getResult()

        XCTAssertEqual(calculationManager.elements.last, "7")
        XCTAssertTrue(calculationManager.expressionHaveResult)
    }

    func testGivenExpression4Minus3_WhenGettingResult_ThenResultIs1() {
        calculationManager.addNumber("4")
        calculationManager.addOperator(.substraction)
        calculationManager.addNumber("3")

        calculationManager.getResult()

        XCTAssertEqual(calculationManager.elements.last, "1")
        XCTAssertTrue(calculationManager.expressionHaveResult)
    }

    func testGivenExpression3Multiply4_WhenGettingResult_ThenResultIs12() {
        calculationManager.addNumber("3")
        calculationManager.addOperator(.multiplication)
        calculationManager.addNumber("4")

        calculationManager.getResult()

        XCTAssertEqual(calculationManager.elements.last, "12")
        XCTAssertTrue(calculationManager.expressionHaveResult)
    }

    func testGivenExpression6Divide3_WhenGettingResult_ThenResultIs2() {
        calculationManager.addNumber("6")
        calculationManager.addOperator(.division)
        calculationManager.addNumber("3")

        calculationManager.getResult()

        XCTAssertEqual(calculationManager.elements.last, "2")
        XCTAssertTrue(calculationManager.expressionHaveResult)
    }

    func testGivenExpressionWithUnknownOperator_WhenGettingResult_ThenResultIsError() {
        calculationManager.elements = ["3", "&", "4"]

        calculationManager.getResult()

        XCTAssertEqual(calculationManager.elements.last, "Error")
    }

    func testGivenExpressionWithAdditionAndMultiplication_WhenGettingResult_ThenResultShouldTakeCareOfPriority() {
        calculationManager.addNumber("3")
        calculationManager.addOperator(.addition)
        calculationManager.addNumber("4")
        calculationManager.addOperator(.multiplication)
        calculationManager.addNumber("2")
        calculationManager.addOperator(.substraction)
        calculationManager.addNumber("5")

        calculationManager.getResult()

        XCTAssertEqual(calculationManager.elements.last, "6")
    }

    func testGivenCalculation_WhenClearing_ThenCalculationShouldBeCleared() {
        calculationManager.addNumber("3")
        calculationManager.addOperator(.addition)
        calculationManager.addNumber("4")
        calculationManager.getResult()

        calculationManager.clear()

        XCTAssertNil(calculationManager.elements.first)
    }

    func testGivenCalculationCleared_WhenGoingToAddOperator_ThenCannotAddOperatorAndExpressionNotCorrect() {
        calculationManager.elements = []

        XCTAssertFalse(calculationManager.canAddOperator)
        XCTAssertFalse(calculationManager.expressionIsCorrect)
    }
}
