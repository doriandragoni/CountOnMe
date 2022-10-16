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

    // MARK: - Properties
    let calculationManager = CalculationManager()
    let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .alert)

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        initAlert()
    }

    // MARK: - Functions
    private func initAlert() {
        alertVC.title = "Zéro!"
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    }

    private func showOperatorAlreadyAddedAlert() {
        alertVC.message = "Un operateur est déja mis !"
        showAlert()
    }

    private func showEnterCorrectExpressionAlert() {
        alertVC.message = "Entrez une expression correcte !"
        showAlert()
    }

    private func showStartNewCalculationAlert() {
        alertVC.message = "Démarrez un nouveau calcul !"
        showAlert()
    }

    private func showAlert() {
        self.present(alertVC, animated: true, completion: nil)
    }

    private func updateTextView() {
        textView.text = calculationManager.getTextViewValue()
    }

    // MARK: - Actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        // Check if the clicked button has a value in his title
        if let numberText = sender.title(for: .normal) {
            calculationManager.addNumber(numberText)
            updateTextView()
        }
    }

    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        // Check if the clicked button has a value in his title
        // and if this value is an operator
        if let operatorText = sender.title(for: .normal),
           let operatorTextValue = OperationType(rawValue: operatorText) {
            guard calculationManager.lastIsNotOperator else {
                return showOperatorAlreadyAddedAlert()
            }

            guard !calculationManager.expressionHasResult else {
                return showStartNewCalculationAlert()
            }

            calculationManager.addOperator(operatorTextValue)
            updateTextView()
        }
    }

    @IBAction func tappedClearButton(_ sender: UIButton) {
        calculationManager.clear()
        updateTextView()
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculationManager.lastIsNotOperator else {
            return showEnterCorrectExpressionAlert()
        }

        guard calculationManager.expressionHasEnoughElements && !calculationManager.expressionHasResult else {
            return showStartNewCalculationAlert()
        }

        calculationManager.getResult()
        updateTextView()
    }
}
