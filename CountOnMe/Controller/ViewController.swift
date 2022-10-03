//
//  ViewController.swift
//  CountOnMe
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    // MARK: - Properties
    let calculationManager = CalculationManager()

    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Functions
    private func showOperatorAlreadyAddedAlert() {
        let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    private func showEnterCorrectExpressionAlert() {
        let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    private func showStartNewCalculationAlert() {
        let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    private func updateTextView() {
        textView.text = calculationManager.textFieldValue()
    }

    // MARK: - Action
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        if let numberText = sender.title(for: .normal) {
            calculationManager.addNumber(numberText)
            updateTextView()
        }
    }

    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if calculationManager.canAddOperator {
            calculationManager.addOperator(.addition)
            updateTextView()
        } else {
            showOperatorAlreadyAddedAlert()
        }
    }

    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if calculationManager.canAddOperator {
            calculationManager.addOperator(.substraction)
            updateTextView()
        } else {
            showOperatorAlreadyAddedAlert()
        }
    }

    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if calculationManager.canAddOperator {
            calculationManager.addOperator(.multiplication)
            updateTextView()
        } else {
            showOperatorAlreadyAddedAlert()
        }
    }

    @IBAction func tappedDivisonButton(_ sender: UIButton) {
        if calculationManager.canAddOperator {
            calculationManager.addOperator(.division)
            updateTextView()
        } else {
            showOperatorAlreadyAddedAlert()
        }
    }

    @IBAction func tappedClearButton(_ sender: UIButton) {
        calculationManager.clear()
        updateTextView()
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculationManager.expressionIsCorrect else {
            return showEnterCorrectExpressionAlert()
        }

        guard calculationManager.expressionHaveEnoughElement else {
            return showStartNewCalculationAlert()
        }

        calculationManager.getResult()
        updateTextView()
    }
}
