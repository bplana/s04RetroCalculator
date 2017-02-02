//
//  ViewController.swift
//  s04RetroCalculator
//
//  Created by bernadette on 1/20/17.
//  Copyright © 2017 Bernadette P. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    @IBOutlet weak var outputLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // path to where button sound is (url)
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")  //This is just a string for now
    
        // need to turn the string into a url
        let soundURL = URL(fileURLWithPath: path!)
        
        // "do this", and if it fails, "do this instead"
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
            runningNumber += "\(sender.tag)"
            outputLbl.text = runningNumber
    }
    
    @IBAction func operationPressed(sender: UIButton) {
        playSound()
    }
    
    @IBAction func onMultiplyPresed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onDividePresed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onSubtractPresed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPresed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        currentOperation = Operation.Empty
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
        outputLbl.text = "0"
        
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        if currentOperation != Operation.Empty {
            
            // a user selected an operator, but then selected another operator without first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                // what will happen when one of the operator buttons are pressed
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                // assign the result
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
            
        } else {
            
            // this is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }



}

