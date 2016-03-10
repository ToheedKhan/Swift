//
//  ViewController.swift
//  Calculator
//
//  Created by Toheed Khan on 09/11/15.
//  Copyright (c) 2015 Toheed Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
//    @IBOutlet var display: [UILabel]!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
//        let str = "Hi"
        
        if userIsInTheMiddleOfTypingANumber {
           display.text = display.text! + digit
        }
        else {
           display.text = digit
           userIsInTheMiddleOfTypingANumber = true
        }
        
        print("Digit is \(digit)")
    }
    
    @IBAction func appendDot() {
    }
    
    @IBAction func resetCalculator() {
        display.text = "0"
        operandStack.removeAll()
        userIsInTheMiddleOfTypingANumber = false
    }
    
    @IBAction func operate(sender: AnyObject) {
        let operation = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        
        switch operation! {
        case "×" :
//            performOperation(multiply)
//            performOperation({ (opt1: Double, opt2: Double) -> Double in
//                return opt1 * opt2;
//                }
//              )
            /* Without Return */
//            performOperation({ (opt1: Double, opt2: Double) -> Double in
//                 opt1 * opt2;
//                }
//            )
            /* Without argument type */
//            performOperation({ (opt1, opt2) in
//                opt1 * opt2;
//                }
//            )
            
//            performOperation({ (opt1, opt2) in opt1 * opt2 })
            
            /* without argument name */
            performOperation({ $0 * $1 })
            
            /*
                 If a function has an argument, which is a function and if it is the last argument you can pass that argument outside of parenthesis.
                 If there are other arguments as well they can go inside the parenthesis.
                */
            performOperation(){ $0 * $1 }
            
            /* And if this is the only argument you can omit the paranthesis*/
            performOperation { $0 * $1 }



        case "÷":
            performOperation { $0 / $1 }
        case "+":
            performOperation { $0 + $1 }
        case "−":
            performOperation { $0 - $1 }
        case "√":
            performOperation { sqrt($0) }
        case "∏":
            performOperation { M_PI * $0 }
        case "sin":
            performOperation { sin($0) }
        case "cos":
            performOperation { cos($0) }
        default : break
        }
        
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    /*
    This code would work when invoked from Swift, but could easily crash if invoked from Objective-C. To solve this problem, use a type that is not supported by Objective-C to prevent the Swift compiler from exposing the member to the Objective-C runtime:
    
    If it makes sense, mark the member as private to disable inference of @objc.
    Otherwise, use a dummy parameter with a default value, for example: _ nonobjc: () = (). (19826275)
*/
//    private func performOperation(operation: Double -> Double) {
    
    //or
    
//    @objc(methodTow:)
    
    //or
    
    @nonobjc
    func performOperation(operation: Double -> Double) {

        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
//    func multiply(opt1: Double, opt2: Double) -> Double {
//        return opt1 * opt2;
//    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        
        print("operandStack = \(operandStack)")
        
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue;
        }
        set {
          display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

