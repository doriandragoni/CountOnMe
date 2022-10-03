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

    var expressionIsCorrect: Bool {
        guard let element = elements.last else {
            return false
        }
        return !OperationType.isOperationType(element)
    }

    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    var canAddOperator: Bool {
        guard let element = elements.last else {
            return false
        }
        return !OperationType.isOperationType(element)
    }

    var expressionHaveResult: Bool {
        return elements.firstIndex(of: "=") != nil
    }

    // MARK: - Functions
    func textFieldValue() -> String {
        return elements.joined(separator: " ")
    }

    func addNumber(_ numberText: String) {
        if expressionHaveResult {
            elements = []
        }
        // Check if the last element is a number..
        if elements.last?.last?.isNumber == true {
            // ...if yes, append the new number to the last number...
            elements[elements.endIndex - 1].append(numberText)
        } else {
            // ...if not, only append a new number
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
        if !expressionHaveResult {
            // Create local copy of operations
            var operationsToReduce = elements

            // Iterate over operations while an operand still here
            while operationsToReduce.count > 1 {
                var indexOfOperand = 1

                if let index = operationsToReduce.firstIndex(where: { $0 == OperationType.multiplication.rawValue
                    || $0 == OperationType.division.rawValue }) {
                    indexOfOperand = index
                }

                let left = Float(operationsToReduce[indexOfOperand - 1])!
                let operand = operationsToReduce[indexOfOperand]
                let right = Float(operationsToReduce[indexOfOperand + 1])!

                var result: Float?
                switch operand {
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

                if let result = result {
                    operationsToReduce.replaceSubrange((indexOfOperand - 1)...(indexOfOperand + 1),
                                                       with: ["\(result.clean)"])
                } else {
                    break
                }
            }

            elements.append("=")
            if !(operationsToReduce.count > 1), let first = operationsToReduce.first {
                elements.append(first)
            } else {
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
