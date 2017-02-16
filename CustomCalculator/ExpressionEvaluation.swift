//
//  ExpressionEvaluation.swift
//  CustomCalculator
//
//  Created by Abhinav Mathur on 12/02/17.
//  Copyright © 2017 Abhinav Mathur. All rights reserved.
//

import Foundation

class ExpressionEvaluation
{
    func evaluate(array : Array<String>) -> Array<String>
    {
        var expression = array
        if expression.contains(Constants.decimalOperator)
        {
            let index = expression.index(of: Constants.decimalOperator)
            let firstValue = expression[expression.index(expression.startIndex, offsetBy: index! - 1)]
            let secondValue = expression[expression.index(expression.startIndex, offsetBy: index! + 1)]
            let newValue = firstValue + secondValue
            expression.insert(newValue, at: index!)
            expression.remove(at: index! - 1)
            expression.remove(at: index! + 1)
            expression.remove(at: index!)
        }
        expression = evaluatePower(arrayVal: expression)
        return expression
    }
    
    func evaluatePower(arrayVal : Array<String>) -> Array<String>
    {
        var expression = arrayVal
        if expression.contains(Constants.powerOperator)
        {
            let index = expression.index(of: Constants.powerOperator)
            let firstValue = Float(expression[expression.index(expression.startIndex, offsetBy: index! - 1)])
            let secondValue = Float(expression[expression.index(expression.startIndex, offsetBy: index! + 1)])
            let newValue = String(pow(firstValue!, secondValue!))
            expression.insert(newValue, at: index!)
            expression.remove(at: index! - 1)
            expression.remove(at: index! + 1)
            expression.remove(at: index!)
        }
        expression = evaluateDivMulMod(arrayVal: expression)
        return expression
    }
    
    func evaluateDivMulMod(arrayVal : Array<String>) -> Array<String>
    {
        var expression = arrayVal
        if expression.contains(Constants.multiplicationOperator) && expression.contains(Constants.divisonOperator) && expression.contains(Constants.modulusOperator)
        {
            let mulindex = expression.index(of: Constants.multiplicationOperator)
            let divindex = expression.index(of: Constants.divisonOperator)
            let modindex = expression.index(of: Constants.modulusOperator)
            let dummyArray = [mulindex!.description,divindex!.description,modindex!.description]
            let sortedArray = dummyArray.sorted()
            
            let op = expression[expression.index(expression.startIndex, offsetBy: Int(sortedArray.first!)!)]
            expression = evauateOperation(arrayValue: expression,operation: op, opCount : 2)
        }
        else if expression.contains(Constants.multiplicationOperator) && expression.contains(Constants.divisonOperator)
        {
            let mulindex = expression.index(of: Constants.multiplicationOperator)
            let divindex = expression.index(of: Constants.divisonOperator)
            if mulindex! < divindex!
            {
                expression = evauateOperation(arrayValue: expression,operation: Constants.multiplicationOperator, opCount : 1)
            }
            else
            {
                expression = evauateOperation(arrayValue: expression,operation: Constants.divisonOperator, opCount : 1)
            }
        }
        else if expression.contains(Constants.divisonOperator) && expression.contains(Constants.modulusOperator)
        {
            let modindex = expression.index(of: Constants.modulusOperator)
            let divindex = expression.index(of: Constants.divisonOperator)
            if modindex! < divindex!
            {
                expression = evauateOperation(arrayValue: expression,operation: Constants.modulusOperator, opCount : 1)
            }
            else
            {
                expression = evauateOperation(arrayValue: expression,operation: Constants.divisonOperator, opCount : 1)
            }
        }
        else if expression.contains(Constants.multiplicationOperator) && expression.contains(Constants.modulusOperator)
        {
            let mulindex = expression.index(of: Constants.multiplicationOperator)
            let modindex = expression.index(of: Constants.modulusOperator)
            if mulindex! < modindex!
            {
                expression = evauateOperation(arrayValue: expression,operation: Constants.multiplicationOperator, opCount : 1)
            }
            else
            {
                expression = evauateOperation(arrayValue: expression,operation: Constants.modulusOperator, opCount : 1)
            }
        }
        else if expression.contains(Constants.multiplicationOperator)
        {
            expression = evauateOperation(arrayValue: expression,operation: Constants.multiplicationOperator, opCount : 0)
        }
        else if expression.contains(Constants.divisonOperator)
        {
            expression = evauateOperation(arrayValue: expression,operation: Constants.divisonOperator, opCount : 0)
        }
        else if expression.contains(Constants.modulusOperator)
        {
            expression = evauateOperation(arrayValue: expression,operation: Constants.modulusOperator, opCount : 0)
        }
        else
        {
            expression = evaluateAddSub(arrayVal: expression)
        }
        return expression
    }
    
    func evauateOperation(arrayValue : Array<String>, operation : String, opCount : Int) -> Array<String>
    {
        var expression = arrayValue
        var newValue : String = ""
        var secondValue : Float = 0.0
        let index = expression.index(of: operation)
        let firstValue = Float(expression[expression.index(expression.startIndex, offsetBy: index! - 1)])
        let secVal = expression[expression.index(expression.startIndex, offsetBy: index! + 1)]
        if secVal == Constants.subtractionOperator
        {
            secondValue = -Float(expression[expression.index(expression.startIndex, offsetBy: index! + 2)])!
            expression.remove(at: index! + 1)
        }
        else if secVal == Constants.additionOperator
        {
            secondValue = +Float(expression[expression.index(expression.startIndex, offsetBy: index! + 2)])!
            expression.remove(at: index! + 1)
        }
        else
        {
            secondValue = Float(expression[expression.index(expression.startIndex, offsetBy: index! + 1)])!
        }
        if operation == Constants.multiplicationOperator
        {
            newValue = String(firstValue! * secondValue)
        }
        else if operation == Constants.divisonOperator
        {
            newValue = String(firstValue! / secondValue)
        }
        else if operation == Constants.modulusOperator
        {
            newValue = String(firstValue!.truncatingRemainder(dividingBy: secondValue))
        }
        expression.insert(newValue, at: index!)
        expression.remove(at: index! - 1)
        expression.remove(at: index! + 1)
        expression.remove(at: index!)
        if opCount > 1
        {
            expression = evaluateDivMulMod(arrayVal: expression)
        }
        else
        {
            expression = evaluateAddSub(arrayVal: expression)
        }
        return expression
    }
    
    func evaluateAddSub(arrayVal : Array<String>) -> Array<String>
    {
        var expression = arrayVal

        if expression.contains(Constants.additionOperator) && expression.contains(Constants.subtractionOperator)
        {
            let addindex = expression.index(of: Constants.additionOperator)
            let subindex = expression.index(of: Constants.subtractionOperator)
            if addindex! < subindex!
            {
                let index = expression.index(of: Constants.additionOperator)
                let firstValue = expression[expression.index(expression.startIndex, offsetBy: index! - 1)]
                let secondValue = expression[expression.index(expression.startIndex, offsetBy: index! + 1)]
                let newValue = String(Float(firstValue)! + Float(secondValue)!)
                expression.insert(newValue, at: index!)
                expression.remove(at: index! - 1)
                expression.remove(at: index! + 1)
                expression.remove(at: index!)
            }
            else
            {
                let index = expression.index(of: Constants.subtractionOperator)
                if expression.index(expression.startIndex, offsetBy: index! - 1) < 0
                {
                    var newValue : String = ""
                    let firstValue = Float(expression[expression.index(expression.startIndex, offsetBy: index! + 1)])
                    let secondValue = Float(expression[expression.index(expression.startIndex, offsetBy: index! + 3)])
                    if expression[expression.index(expression.startIndex, offsetBy: index! + 2)] == Constants.multiplicationOperator
                    {
                        newValue = String(-firstValue! * secondValue!)
                    }
                    else if expression[expression.index(expression.startIndex, offsetBy: index! + 2)] == Constants.divisonOperator
                    {
                        newValue = String(-firstValue! / secondValue!)
                    }
                    else if expression[expression.index(expression.startIndex, offsetBy: index! + 2)] == Constants.modulusOperator
                    {
                        newValue = String(-firstValue!.truncatingRemainder(dividingBy: secondValue!))
                    }
                    else if expression[expression.index(expression.startIndex, offsetBy: index! + 2)] == Constants.additionOperator
                    {
                        newValue = String(-firstValue! + secondValue!)
                    }
                    else if expression[expression.index(expression.startIndex, offsetBy: index! + 2)] == Constants.subtractionOperator
                    {
                        newValue = String(-firstValue! - secondValue!)
                    }
                    expression.insert(newValue, at: index!)
                    expression.remove(at: index! + 1)
                    expression.remove(at: index! + 1)
                    expression.remove(at: index! + 1)
                    expression.remove(at: index! + 1)
                }
                else
                {
                    let firstValue = expression[expression.index(expression.startIndex, offsetBy: index! - 1)]
                    let secondValue = expression[expression.index(expression.startIndex, offsetBy: index! + 1)]
                    let newValue = String(Float(firstValue)! - Float(secondValue)!)
                    expression.insert(newValue, at: index!)
                    expression.remove(at: index! - 1)
                    expression.remove(at: index! + 1)
                    expression.remove(at: index!)
                }
            }
        }
        else if expression.contains(Constants.additionOperator)
        {
            let index = expression.index(of: Constants.additionOperator)
            var firstValue : String = ""
            if expression.index(expression.startIndex, offsetBy: index! - 1) == -1
            {
                firstValue = "0"
                let secondValue = expression[expression.index(expression.startIndex, offsetBy: index! + 1)]
                let newValue = String(Float(firstValue)! + Float(secondValue)!)
                expression.insert(newValue, at: index!)
                expression.remove(at: index! + 1)
                expression.remove(at: index! + 1)
            }
            else
            {
                firstValue = expression[expression.index(expression.startIndex, offsetBy: index! - 1)]
                let secondValue = expression[expression.index(expression.startIndex, offsetBy: index! + 1)]
                let newValue = String(Float(firstValue)! + Float(secondValue)!)
                expression.insert(newValue, at: index!)
                expression.remove(at: index! - 1)
                expression.remove(at: index! + 1)
                expression.remove(at: index!)
            }
        }
        else if expression.contains(Constants.subtractionOperator)
        {
            let index = expression.index(of: Constants.subtractionOperator)
            var firstValue : String = ""
            if expression.index(expression.startIndex, offsetBy: index! - 1) == -1
            {
                firstValue = "0"
                let secondValue = expression[expression.index(expression.startIndex, offsetBy: index! + 1)]
                let newValue = String(Float(firstValue)! - Float(secondValue)!)
                expression.insert(newValue, at: index!)
                expression.remove(at: index! + 1)
                expression.remove(at: index! + 1)
            }
            else
            {
                firstValue = expression[expression.index(expression.startIndex, offsetBy: index! - 1)]
                let secondValue = expression[expression.index(expression.startIndex, offsetBy: index! + 1)]
                let newValue = String(Float(firstValue)! - Float(secondValue)!)
                expression.insert(newValue, at: index!)
                expression.remove(at: index! - 1)
                expression.remove(at: index! + 1)
                expression.remove(at: index!)
            }
        }
        else
        {
            return expression
        }
        return expression
    }
}
