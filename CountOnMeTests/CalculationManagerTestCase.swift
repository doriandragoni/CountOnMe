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

    private func writeCalculation(_ operand: OperationType) {
        calculationManager.addNumber("3")
        calculationManager.addOperator(operand)
        calculationManager.addNumber("2")
    }

    func testGivenNewCalculation_WhenAddingNumber_ThenNumberAdded() {
        calculationManager.addNumber("3")

        XCTAssertEqual(calculationManager.elements.last, "3")
        XCTAssertTrue(calculationManager.canAddOperator)
    }

    func testGivenNumberAdded_WhenAddingNumber_ThenNumberAppendedToTheLastNumber() {
        calculationManager.addNumber("3")

        calculationManager.addNumber("2")

        XCTAssertEqual(calculationManager.elements.last, "32")
    }

    func testGivenExpressionHaveResult_WhenAddingNumber_ThenClearElementsAndStartNewCalculation() {
        writeCalculation(.addition)
        calculationManager.getResult()

        calculationManager.addNumber("5")

        XCTAssertEqual(calculationManager.elements, ["5"])
    }

    func testGivenNumberAdded_WhenAddingOperator_ThenOperatorAdded() {
        calculationManager.addNumber("3")
        calculationManager.addOperator(.addition)

        XCTAssertEqual(calculationManager.elements.last, "+")
        XCTAssertFalse(calculationManager.canAddOperator)
    }

    func testGivenNumberAndOperatorAdded_WhenAddingNumber_ThenExpressionIsCorrectAndHaveEnoughElements() {
        writeCalculation(.addition)

        XCTAssertTrue(calculationManager.expressionIsCorrect)
        XCTAssertTrue(calculationManager.expressionHaveEnoughElement)
    }

    func testGivenExpression3Plus2_WhenGettingResult_ThenResultIs5() {
        writeCalculation(.addition)

        calculationManager.getResult()

        XCTAssertEqual(calculationManager.elements.last, "5")
        XCTAssertTrue(calculationManager.expressionHaveResult)
    }

    func testGivenExpression3Minus2_WhenGettingResult_ThenResultIs1() {
        writeCalculation(.substraction)

        calculationManager.getResult()

        XCTAssertEqual(calculationManager.elements.last, "1")
        XCTAssertTrue(calculationManager.expressionHaveResult)
    }

    func testGivenExpression3Multiply2_WhenGettingResult_ThenResultIs6() {
        writeCalculation(.multiplication)

        calculationManager.getResult()

        XCTAssertEqual(calculationManager.elements.last, "6")
        XCTAssertTrue(calculationManager.expressionHaveResult)
    }

    func testGivenExpression3Divide2_WhenGettingResult_ThenResultIs1() {
        writeCalculation(.division)

        calculationManager.getResult()

        XCTAssertEqual(calculationManager.elements.last, "1")
        XCTAssertTrue(calculationManager.expressionHaveResult)
    }

    func testGivenExpressionWithUnknownOperator_WhenGettingResult_ThenResultIsError() {
        calculationManager.elements = ["3", "&", "2"]

        calculationManager.getResult()

        XCTAssertEqual(calculationManager.elements.last, "Error")
    }

    func testGivenExpressionWithAdditionAndMultiplication_WhenGettingResult_ThenResultShouldTakeCareOfPriority() {
        calculationManager.addNumber("3")
        calculationManager.addOperator(.addition)
        calculationManager.addNumber("2")
        calculationManager.addOperator(.multiplication)
        calculationManager.addNumber("4")
        calculationManager.addOperator(.substraction)
        calculationManager.addNumber("5")

        calculationManager.getResult()

        XCTAssertEqual(calculationManager.elements.last, "6")
    }

    func testGivenCalculation_WhenClearing_ThenCalculationShouldBeCleared() {
        writeCalculation(.addition)
        calculationManager.getResult()

        calculationManager.clear()

        XCTAssertNil(calculationManager.elements.first)
    }

    func testGivenCalculationCleared_WhenGoingToAddOperator_ThenCannotAddOperatorAndExpressionNotCorrect() {
        calculationManager.elements = []

        XCTAssertFalse(calculationManager.canAddOperator)
        XCTAssertFalse(calculationManager.expressionIsCorrect)
    }

    func testGivenCalculationWritten_WhenUpdatingTheTextView_ThenTextViewIsProperlyDisplayed() {
        writeCalculation(.addition)

        let textView = calculationManager.textFieldValue()

        XCTAssertEqual(textView, "3 + 2")
    }
}
