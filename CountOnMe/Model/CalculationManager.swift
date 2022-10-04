//
//  CalculationManager.swift
//  CountOnMe
//
//  Created by Dorian Dragoni on 01/09/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

class CalculationManager {
    // MARK: - Properties
    var elements = [String]()

    var lastIsNotOperator: Bool {
        guard let element = elements.last else {
            return false
        }
        return !OperationType.isOperationType(element)
    }

    var expressionHasEnoughElements: Bool {
        return elements.count >= 3
    }

    var expressionHasResult: Bool {
        return elements.firstIndex(of: "=") != nil
    }

    // MARK: - Functions
    func getTextViewValue() -> String {
        return elements.joined(separator: " ")
    }

    func addNumber(_ numberText: String) {
        // If expression has a result, start a new calculation
        if expressionHasResult {
            clear()
        }
        // Check if the last character of the last element is a number..
        if elements.last?.last?.isNumber == true {
            // ...if yes, append the new number to the last number...
            elements[elements.endIndex - 1].append(numberText)
        } else {
            // ...if not, just append a new number
            elements.append(numberText)
        }
    }

    func addOperator(_ operationType: OperationType) {
        elements.append(operationType.rawValue)
    }

    func clear() {
        elements = []
    }

    func getResult() {
        if !expressionHasResult {
            // Create local copy of operations
            var operationsToReduce = elements

            // Iterate over operations while an operator still here
            while operationsToReduce.count > 1 {
                // Set the index of the operator to 1 by default
                var indexOfOperator = 1

                // If there is a multiplication or division operator, re-set the index of the operator
                if let index = operationsToReduce.firstIndex(where: { $0 == OperationType.multiplication.rawValue
                    || $0 == OperationType.division.rawValue }) {
                    indexOfOperator = index
                }

                let left = Float(operationsToReduce[indexOfOperator - 1])!
                let operatorValue = operationsToReduce[indexOfOperator]
                let right = Float(operationsToReduce[indexOfOperator + 1])!

                var result: Float?
                switch operatorValue {
                case OperationType.addition.rawValue:
                    result = left + right
                case OperationType.substraction.rawValue:
                    result = left - right
                case OperationType.multiplication.rawValue:
                    result = left * right
                case OperationType.division.rawValue:
                    result = left / right
                default:
                    result = nil
                }

                if let result = result, !result.isNaN {
                    // Replace the three elements used for the calculation with the result
                    operationsToReduce.replaceSubrange((indexOfOperator - 1)...(indexOfOperator + 1),
                                                       with: ["\(result.clean)"])
                } else {
                    // If no result, exit the while loop
                    break
                }
            }

            elements.append("=")
            // If there a final result, show it...
            if !(operationsToReduce.count > 1), let finalResult = operationsToReduce.first {
                elements.append(finalResult)
            } else {
                // ...else, display "Error"
                elements.append("Error")
            }
        }
    }
}

// Use this to display the decimals only if there are any
extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
