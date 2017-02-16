//
//  ViewController.swift
//  CustomCalculator
//
//  Created by Abhinav Mathur on 12/02/17.
//  Copyright © 2017 Abhinav Mathur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var equals: UIButton!
 
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var sub: UIButton!
    @IBOutlet weak var decimal: UIButton!
    @IBOutlet weak var zero: UIButton!

    @IBOutlet weak var multiply: UIButton!
    @IBOutlet weak var power: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var one: UIButton!
    
    @IBOutlet weak var divide: UIButton!
    @IBOutlet weak var mod: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var four: UIButton!
    
    @IBOutlet weak var clear: UIButton!
    @IBOutlet weak var remove: UIButton!
    @IBOutlet weak var nine: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var seven: UIButton!
    
    var displayString = ""
    
    var inputArray : Array<String> = []
    var outputArray : Array<String> = []

    var decimalCount : Int = 0
    var operatorCount : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.displayLabel.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleButtonTap(_ sender: UIButton) {
        
        if sender.titleLabel!.text! == Constants.clearSingleInput
        {
            self.handleSingleInputClear()
        }
        else if sender.titleLabel!.text! == Constants.clearAllInput
        {
            self.handleAllInputClear()
        }
        else if sender.titleLabel!.text! == Constants.equalsOperator
        {
            if operatorCount > 0 && (self.inputArray.last! != Constants.additionOperator && self.inputArray.last! != Constants.subtractionOperator && self.inputArray.last! != Constants.multiplicationOperator && self.inputArray.last! != Constants.divisonOperator && self.inputArray.last! != Constants.modulusOperator && self.inputArray.last! != Constants.powerOperator && self.inputArray.last! != Constants.decimalOperator)
            {
                self.startEvaluation()
                self.outputArray = self.inputArray
                self.displayString = self.inputArray.first!
                self.displayLabel.text = self.inputArray.first!
                if self.displayString.contains(Constants.decimalOperator)
                {
                    decimalCount = 1
                }
                else
                {
                    decimalCount = 0
                }
                operatorCount = 0
            }
        }
        else if self.displayString.characters.count == 0 && sender.titleLabel!.text! == Constants.decimalOperator
        {
            self.displayString.append("0.")
            self.inputArray.append("0.")
            self.displayLabel.text = self.displayString
        }
        else
        {
            self.handleInput(inputText: sender.titleLabel!.text!)
        }
    }
    
    func handleSingleInputClear()
    {
        if self.inputArray.last!.contains(Constants.notDefined) || self.inputArray.last!.contains(Constants.infinity)
        {
            self.inputArray.removeAll()
            self.outputArray.removeAll()
            self.displayString = ""
            self.displayLabel.text = "0"
        }
        else
        {
            if self.displayString.characters.count > 0
            {
                let endIndex = self.displayString.index(self.displayString.endIndex, offsetBy: -1)
                let truncated = self.displayString.substring(to: endIndex)
                var decimalCounterInCurrentString = 0
                for i in 0 ..< truncated.characters.count
                {
                    if truncated[truncated.index(truncated.startIndex, offsetBy: i)] == Character(Constants.decimalOperator)
                    {
                        decimalCounterInCurrentString += 1
                    }
                }
                self.decimalCount = decimalCounterInCurrentString
                self.displayString = truncated
                let val = self.inputArray.last
                let valEndIndex = val!.index(val!.endIndex, offsetBy: -1)
                let valTruncated = val!.substring(to: valEndIndex)
                self.inputArray.removeLast()
                self.inputArray.append(valTruncated)
                self.outputArray.removeAll()
                self.outputArray.append(valTruncated)
                if truncated.characters.count > 0
                {
                    self.displayLabel.text = self.displayString
                }
                else
                {
                    self.displayLabel.text = "0"
                }
            }
            else
            {
                self.displayLabel.text = "0"
            }
        }
    }
    
    func handleAllInputClear()
    {
        self.displayString.removeAll()
        self.inputArray.removeAll()
        self.outputArray.removeAll()
        self.decimalCount = 0
        self.operatorCount = 0
        self.displayLabel.text = "0"
    }
    
    func handleInput(inputText : String)
    {
        if inputText == Constants.additionOperator || inputText == Constants.subtractionOperator || inputText == Constants.multiplicationOperator || inputText == Constants.divisonOperator || inputText == Constants.modulusOperator || inputText == Constants.powerOperator
        {
            if self.inputArray.count > 0
            {
                if self.inputArray.last!.contains(Constants.notDefined) || self.inputArray.last!.contains(Constants.infinity)
                {
                    self.inputArray.removeAll()
                    self.outputArray.removeAll()
                    self.displayString = ""
                    self.displayLabel.text = "0"
                }
                else
                {
                    if self.inputArray.last! == Constants.additionOperator || self.inputArray.last! == Constants.subtractionOperator || self.inputArray.last! == Constants.multiplicationOperator || self.inputArray.last! == Constants.divisonOperator || self.inputArray.last! == Constants.modulusOperator || self.inputArray.last! == Constants.powerOperator || self.inputArray.last! == Constants.decimalOperator
                    {
                        
                    }
                    else
                    {
                        
                        self.inputArray.append(inputText)
                        self.displayString.append(inputText)
                        self.displayLabel.text = self.displayString
                        operatorCount += 1
                    }
                }
            }
            else
            {
                if inputText == Constants.additionOperator || inputText == Constants.subtractionOperator
                {
                    self.inputArray.append(inputText)
                    self.displayString.append(inputText)
                    self.displayLabel.text = self.displayString
                    operatorCount += 1
                }
                else
                {
                    self.displayLabel.text = "0"
                }
            }
        }
        else if inputText == Constants.decimalOperator
        {
            if decimalCount <= operatorCount
            {
                if self.inputArray.last!.contains(Constants.notDefined) || self.inputArray.last!.contains(Constants.infinity)
                {
                    self.inputArray.removeAll()
                    self.outputArray.removeAll()
                    self.displayString.removeAll()
                    self.displayString.append(inputText)
                    self.displayLabel.text = self.displayString
                    decimalCount += 1
                    self.inputArray.append(inputText)
                }
                else
                {
                    if self.inputArray.last! == Constants.additionOperator || self.inputArray.last! == Constants.subtractionOperator || self.inputArray.last! == Constants.multiplicationOperator || self.inputArray.last! == Constants.divisonOperator || self.inputArray.last! == Constants.modulusOperator || self.inputArray.last! == Constants.powerOperator
                    {
                        self.displayString.append(inputText)
                        self.displayLabel.text = self.displayString
                        decimalCount += 1
                        self.inputArray.append(inputText)
                    }
                    else
                    {
                        var val = self.inputArray.last!
                        val.append(inputText)
                        self.inputArray.removeLast()
                        self.inputArray.append(val)
                        self.displayString.append(inputText)
                        self.displayLabel.text = self.displayString
                        decimalCount += 1
                    }
                }
            }
            else
            {
                
            }
        }
        else
        {
            if outputArray.count > 0 && operatorCount == 0
            {
                if self.inputArray.last!.contains(Constants.notDefined) || self.inputArray.last!.contains(Constants.infinity)
                {
                    self.inputArray.removeAll()
                    self.outputArray.removeAll()
                    self.displayString.removeAll()
                    self.displayString.append(inputText)
                    self.displayLabel.text = self.displayString
                    self.inputArray.append(inputText)
                }
                else
                {
                    if self.outputArray == self.inputArray
                    {
                        var currentDisplayValue = self.outputArray.first!
                        currentDisplayValue.append(inputText)
                        self.inputArray.removeAll()
                        self.inputArray.append(currentDisplayValue)
                        self.outputArray.removeAll()
                        self.outputArray.append(currentDisplayValue)
                        self.displayString.append(inputText)
                        self.displayLabel.text = self.displayString
                    }
                    else
                    {
                        var val = self.inputArray.last!
                        val.append(inputText)
                        self.inputArray.removeLast()
                        self.inputArray.append(val)
                        self.displayString.append(inputText)
                        self.displayLabel.text = self.displayString
                        self.outputArray.removeAll()
                        self.outputArray.append(val)
                    }
                }
            }
            else
            {
                if self.inputArray.count > 0
                {
                    if self.inputArray.last!.contains(Constants.notDefined) || self.inputArray.last!.contains(Constants.infinity)
                    {
                        self.inputArray.removeAll()
                        self.outputArray.removeAll()
                        self.displayString.removeAll()
                        self.displayString.append(inputText)
                        self.displayLabel.text = self.displayString
                        self.inputArray.append(inputText)
                    }
                    else
                    {
                        if self.inputArray.last! == Constants.additionOperator || self.inputArray.last! == Constants.subtractionOperator || self.inputArray.last! == Constants.multiplicationOperator || self.inputArray.last! == Constants.divisonOperator || self.inputArray.last! == Constants.modulusOperator || self.inputArray.last! == Constants.powerOperator
                        {
                            self.inputArray.append(inputText)
                            self.displayString.append(inputText)
                            self.displayLabel.text = self.displayString
                        }
                        else
                        {
                            var val = self.inputArray.last!
                            val.append(inputText)
                            self.inputArray.removeLast()
                            self.inputArray.append(val)
                            self.displayString.append(inputText)
                            self.displayLabel.text = self.displayString
                        }
                    }
                }
                else
                {
                    self.inputArray.append(inputText)
                    self.displayString.append(inputText)
                    self.displayLabel.text = self.displayString
                }
            }
        }
    }
    
    func startEvaluation()
    {
        while inputArray.count > 1 {
            inputArray = ExpressionEvaluation().evaluate(array: self.inputArray)
        }
    }
}

