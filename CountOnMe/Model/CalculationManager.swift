//
//  CalculationManager.swift
//  CountOnMe
//
//  Created by Dorian Dragoni on 01/09/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

class CalculationManager {
    let operations: [OperationType: String] = [
        .addition: "+",
        .substraction: "-",
        .multiplication: "x",
        .division: "/"
    ]

    var elements = [String]()

    var expressionIsCorrect: Bool {
        return elements.last != operations[.addition] && elements.last != operations[.substraction]
    }

    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    var canAddOperator: Bool {
        return elements.last != operations[.addition] && elements.last != operations[.substraction]
        && elements.last != operations[.multiplication] && elements.last != operations[.division]
    }

    var expressionHaveResult: Bool {
        return elements.firstIndex(of: "=") != nil
    }

    func addNumber(_ numberText: String) {
        if expressionHaveResult {
            elements = []
        }
        // Check if the last element is a number..
        if elements.last?.last?.isNumber == true {
            // ...if yes, I append the new number to the last number...
            elements[elements.endIndex - 1].append(numberText)
        } else {
            // ...if not, I only append a new number
            elements.append(numberText)
        }
    }

    func addOperator(_ operationType: OperationType) {
        if let operation = operations[operationType] {
            if elements.last?.last?.isNumber == true {
                elements.append(operation)
            } else if operation != elements.last {
                elements[elements.endIndex - 1] = operation
            }
        }
    }

    func getResult() {
        if expressionIsCorrect && expressionHaveEnoughElement {
            // Create local copy of operations
            var operationsToReduce = elements

            // Iterate over operations while an operand still here
            while operationsToReduce.count > 1 {
                let left = Int(operationsToReduce[0])!
                let operand = operationsToReduce[1]
                let right = Int(operationsToReduce[2])!

                var result: Int
                switch operand {
                case operations[.addition]:
                    result = left + right
                case operations[.substraction]:
                    result = left - right
                case operations[.multiplication]:
                    result = left * right
                case operations[.division]:
                    result = left / right
                default:
                    fatalError("Unknown operator !")
                }

                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                operationsToReduce.insert("\(result)", at: 0)
            }

            elements.append("=")
            elements.append(operationsToReduce.first!)
        }
    }
}

enum OperationType {
    case addition, substraction, multiplication, division
}
