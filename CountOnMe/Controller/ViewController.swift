//
//  ViewController.swift
//  CountOnMe
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    let calculationManager = CalculationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func updateTextView() {
        textView.text = calculationManager.elements.joined(separator: " ")
    }

    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        if let numberText = sender.title(for: .normal) {
            calculationManager.addNumber(numberText)
            updateTextView()
        }
    }

    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calculationManager.addOperator(.addition)
        updateTextView()
//        if calculationManager.canAddOperator {
//            calculationManager.elements.append("+")
//            updateTextView()
//        } else {
//            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !",
//                                            preferredStyle: .alert)
//            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            self.present(alertVC, animated: true, completion: nil)
//        }
    }

    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calculationManager.addOperator(.substraction)
        updateTextView()

        // Should I keep the alerts?

//        if calculationManager.canAddOperator {
//            calculationManager.elements.append("-")
//            updateTextView()
//        } else {
//            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !",
//                                            preferredStyle: .alert)
//            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            self.present(alertVC, animated: true, completion: nil)
//        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculationManager.getResult()
        updateTextView()

        // Should I keep the alerts?

//        guard calculationManager.expressionIsCorrect else {
//            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !",
//                                            preferredStyle: .alert)
//            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            return self.present(alertVC, animated: true, completion: nil)
//        }
//
//        guard calculationManager.expressionHaveEnoughElement else {
//            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !",
//                                            preferredStyle: .alert)
//            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            return self.present(alertVC, animated: true, completion: nil)
//        }
    }

}
