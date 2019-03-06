//
//  ViewController.swift
//  CenterofGravity
//
//  Created by Kyle Jones on 3/5/19.
//  Copyright © 2019 Kyle Jones. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var baseWidthTextField: UITextField!
    @IBOutlet weak var topWidthTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var previousResultLabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        heightTextField.keyboardType = UIKeyboardType.decimalPad
        baseWidthTextField.keyboardType = UIKeyboardType.numberPad
        topWidthTextField.keyboardType = UIKeyboardType.numberPad
        updateUI()
    }
    @IBAction func unwindToMain(_ unwindSegue: UIStoryboardSegue) {
        _ = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }

    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        updateUI()
    }
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        heightTextField.text = ""
        baseWidthTextField.text = ""
        topWidthTextField.text = ""
        updateUI()
    }
    @IBAction func tapOutsideTextField(_ sender: UITapGestureRecognizer) {
        self.view .endEditing(true)
    }
    func calculateCenterOfGravity() -> String? {
        if heightTextField.text == "" &&
            baseWidthTextField.text == "" &&
            topWidthTextField.text  == "" {
            return ""
        }
        guard let heightString = heightTextField.text,
            let baseString = baseWidthTextField.text,
            let topString = topWidthTextField.text,
            let height = Double(heightString),
            let base = Double(baseString),
            let top = Double(topString) else {return nil}
        // Center of gravity equation Y = h (b+2a) / 3 (b + a)
        let centerOfGravityInInches = ((height * 12) * (base + (top * 2.0))) / (3.0 * (base + top))
        let centerOfGravity = centerOfGravityInInches / 12
        let feet = Int(centerOfGravity)
        let inches = Int((centerOfGravity - Double(feet)) * 12)
        return "\(feet) ft. \(inches) in."
    }
    var previousResult: String = ""
    func updateUI () {
        if previousResult == "" {
            previousResultLabel.isHidden = true
        } else {
            previousResultLabel.isHidden = false
            previousResultLabel.text = "Previous result: \(previousResult)"
        }
        if calculateCenterOfGravity() == "" {
            descriptionLabel.text = "Enter trap or shaft dimensions."
            resultLabel.isHidden = true
            resultLabel.text = ""
            clearButton.isHidden = true
        } else if calculateCenterOfGravity() == nil {
            descriptionLabel.text = "Invalid dimensions entered.\nPlease refer to help section."
            resultLabel.isHidden = true
            clearButton.isHidden = false
        } else {
            descriptionLabel.text = "Distance from base to center of gravity is"
            resultLabel.isHidden = false
            resultLabel.text = calculateCenterOfGravity()
            clearButton.isHidden = false
            topWidthTextField.resignFirstResponder()
            previousResult = "\(resultLabel.text ?? "Error")"
            
            
        }
        
    }
}

