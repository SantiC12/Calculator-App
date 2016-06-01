//
//  ViewController.swift
//  calculator
//
//  Created by Santiago Castaño M on 5/28/16.
//  Copyright © 2016 Santi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftvalStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("BtnSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do{
           try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }

    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func OnDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func OnMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)

    }
    
    @IBAction func OnSubstractPressed(sender: AnyObject) {
        processOperation(Operation.Substract)

    }
    
    @IBAction func OnAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)

    }
    
    @IBAction func OnEqualPressed(sender: AnyObject) {
        
        processOperation(currentOperation)
        clearValues()

        
    }
    
    func processOperation(op: Operation){
        playSound()
        if currentOperation != Operation.Empty {
            
            
            //Auser selected an operator, but then selected another operatior
            //but without first selecting an number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftvalStr)! * Double(rightValStr)!)"
                }
                    
                else if currentOperation == Operation.Divide {
                    result = "\(Double(leftvalStr)! / Double(rightValStr)!)"
                }
                    
                else if currentOperation == Operation.Substract{
                    result = "\(Double(leftvalStr)! - Double(rightValStr)!)"
                }
                    
                else if currentOperation == Operation.Add{
                    result = "\(Double(leftvalStr)! + Double(rightValStr)!)"
                }
                
                
                
                
                leftvalStr = result
                
                outputLbl.text = result
            }
            
            currentOperation = op
            
            
        }else {
            //First time operatior has been pressed
            leftvalStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    @IBAction func OnClearPressed(sender: AnyObject) {
        clearValues()
        outputLbl.text = "0"

        
    }
    
    
    func clearValues(){
        
        runningNumber = ""
        leftvalStr = ""
        rightValStr = ""
        currentOperation = Operation.Empty
        result = ""
        
    }
    
    func playSound() {
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
    }
}

