//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Tushar Katyal on 25/06/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    
    
    enum Operation : String {
        
        case Divide
        case Multiply
        case Add
        case Subtract
        case Empty = "Empty"
    }
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftvalStr = ""
    var rightvalStr = ""
    var result = ""
    
    var btnSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = Bundle.main.path(forResource: "btn" , ofType: "wav")
        
        let soundURL = URL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError
        {
            print(err.debugDescription)
        }
        outputLbl.text = "0"
    }
    @IBAction func numberPressed(sender : UIButton){
     playSound()
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    @IBAction func onDividePressed(sender : AnyObject)
    {
        processOperation(operation: .Divide)
    }
    @IBAction func onMultiplyPressed(sender : AnyObject)
    {
        processOperation(operation: .Multiply)
    }
    @IBAction func onAddPressed(sender : AnyObject)
    {
        processOperation(operation: .Add)
    }
    @IBAction func onSubtractPressed(sender : AnyObject)
    {
        processOperation(operation: .Subtract)
    }
    @IBAction func onEqualPRessed(sender : AnyObject)
    {
        processOperation(operation: currentOperation)
    }
    func playSound(){
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    func processOperation(operation : Operation)
    {
        playSound()
        if currentOperation != Operation.Empty {
            // A user selected a operator, but than selected another operator without entering a number
            if runningNumber != "" {
                rightvalStr = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Multiply
                {
                    result = "\(Double(leftvalStr)! * Double(rightvalStr)!)"
                }else if currentOperation == Operation.Divide
                {
                    result = "\(Double(leftvalStr)! / Double(rightvalStr)!)"
                } else if currentOperation == Operation.Add
                {
                    result = "\(Double(leftvalStr)! + Double(rightvalStr)!)"
                } else if currentOperation == Operation.Subtract
                {
                    result = "\(Double(leftvalStr)! - Double(rightvalStr)!)"
                }
                leftvalStr = result
                outputLbl.text = result
        }
            currentOperation = operation
     }
        else{
            // this is the first time an operator has been pressed
            leftvalStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}

