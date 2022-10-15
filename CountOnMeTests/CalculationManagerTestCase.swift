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

    private func writeCalculation(_ operatorValue: OperationType) {
        calculationManager.addNumber("3")
        calculationManager.addOperator(operatorValue)
        calculationManager.addNumber("2")
    }

    func testGivenNewCalculation_WhenAddingNumber_ThenNumberAdded() {
        calculationManager.addNumber("3")

        XCTAssertEqual(calculationManager.elements.last, "3")
        XCTAssertTrue(calculationManager.lastIsNotOperator)
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
        XCTAssertFalse(calculationManager.lastIsNotOperator)
    }

    func testGivenNumberAndOperatorAdded_WhenAddingNumber_ThenExpressionIsCorrectAndHaveEnoughElements() {
        writeCalculation(.addition)

        XCTAssertTrue(calculationManager.lastIsNotOperator)
        XCTAssertTrue(calculationManager.expressionHasEnoughElements)
    }

    func testGivenExpression3Plus2_WhenGettingResult_ThenResultIs5() {
        writeCalculation(.addition)

        calculationManager.getResult()

        XCTAssertEqual(calculationManager.elements.last, "5")
        XCTAssertTrue(calculationManager.expressionHasResult)
    }

    func testGivenExpression3Minus2_WhenGettingResult_ThenResultIs1() {
        writeCalculation(.substraction)

        calculationManager.getResult()

        XCTAssertEqual(calculationManager.elements.last, "1")
        XCTAssertTrue(calculationManager.expressionHasResult)
    }

    func testGivenExpression3Multiply2_WhenGettingResult_ThenResultIs6() {
        writeCalculation(.multiplication)

        calculationManager.getResult()

        XCTAssertEqual(calculationManager.elements.last, "6")
        XCTAssertTrue(calculationManager.expressionHasResult)
    }

    func testGivenExpression3Divide2_WhenGettingResult_ThenResultIs1Point5() {
        writeCalculation(.division)

        calculationManager.getResult()

        XCTAssertEqual(calculationManager.elements.last, "1.5")
        XCTAssertTrue(calculationManager.expressionHasResult)
    }

    func testGivenExpressionWithUnknownOperator_WhenGettingResult_ThenResultIsError() {
        calculationManager.elements = ["3", "&", "2"]

        calculationManager.getResult()

        XCTAssertEqual(calculationManager.elements.last, "Error")
    }

    func testGivenExpressionDivisionBy0_WhenGettingResult_ThenResultIsError() {
        calculationManager.addNumber("3")
        calculationManager.addOperator(.division)
        calculationManager.addNumber("0")

        calculationManager.getResult()

        XCTAssertEqual(calculationManager.elements.last, "Error")
    }

    func testGivenComplexeExpression_WhenGettingResult_ThenResultShouldTakeCareOfPriority() {
        calculationManager.addNumber("3")
        calculationManager.addOperator(.addition)
        calculationManager.addNumber("14")
        calculationManager.addOperator(.multiplication)
        calculationManager.addNumber("6")
        calculationManager.addOperator(.substraction)
        calculationManager.addNumber("30")
        calculationManager.addOperator(.division)
        calculationManager.addNumber("5")
        calculationManager.addOperator(.addition)
        calculationManager.addNumber("12")
        calculationManager.addOperator(.substraction)
        calculationManager.addNumber("48")

        calculationManager.getResult()

        XCTAssertEqual(calculationManager.elements.last, "45")
    }

    func testGivenCalculation_WhenClearing_ThenCalculationShouldBeCleared() {
        writeCalculation(.addition)
        calculationManager.getResult()

        calculationManager.clear()

        XCTAssertNil(calculationManager.elements.first)
    }

    func testGivenCalculationCleared_WhenGoingToAddOperator_ThenCannotAddOperator() {
        calculationManager.elements = []

        XCTAssertFalse(calculationManager.lastIsNotOperator)
    }

    func testGivenCalculationWritten_WhenUpdatingTheTextView_ThenTextViewIsProperlyDisplayed() {
        writeCalculation(.addition)

        let textView = calculationManager.getTextViewValue()

        XCTAssertEqual(textView, "3 + 2")
    }
}
