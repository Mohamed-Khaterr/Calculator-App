//
//  ViewController.swift
//  My Calculator
//
//  Created by Khater on 1/31/22.
//  Copyright © 2022 Khater. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var formula: String?
    var history = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        if let title = sender.currentTitle{
            if label.text != "0" && formula != nil{
                label.text! += title
                formula! += title
            }else{
                label.text = title
                formula = title
            }
        }
    }
    
    @IBAction func equalPressed(_ sender: UIButton) {
        if let form = formula{
            let result = calulate(form)
            label.text = result
            formula = result
            
            history.append(form + " = " + result)
        }else{
            print("Empty")
        }
    }
    
    @IBAction func ACPressed(_ sender: UIButton) {
        label.text = "0"
        formula = nil
    }
    
    @IBAction func plusPressed(_ sender: UIButton) {
        addLast(sender.currentTitle!, "+")
    }
    
    @IBAction func minusPressed(_ sender: UIButton) {
        addLast(sender.currentTitle!, "-")
    }
    
    @IBAction func multiplyPressed(_ sender: UIButton) {
        addLast("*", "*")
    }
    
    @IBAction func dividedPressed(_ sender: UIButton) {
        addLast("/", "/")
    }
    
    @IBAction func percentagePressed(_ sender: UIButton) {
        if formula != nil && label.text != "0" && label.text != ""{
            label.text = calulate(formula! + "*0.01")
            formula = calulate(formula! + "*0.01")
        }
    }
    
    @IBAction func changeSignPressed(_ sender: UIButton) {
        if let text = label.text, label.text != "0" && label.text != "" {
            let old = text
            var theLabel = text
            if label.text?.prefix(1) != "-" {
                theLabel.insert("-", at: theLabel.startIndex)
                label.text = theLabel
            }else{
                theLabel.remove(at: theLabel.startIndex)
                label.text = theLabel
            }
            if old != theLabel{
                formula = formula?.replacingOccurrences(of: old, with: theLabel)
            }
            
        }
    }
    
    func addLast(_ title: String, _ sign: String){
        if formula != nil && formula!.suffix(1) != sign {
            formula? += title
            label.text = ""
        }
    }
    
    func calulate(_ format: String) -> String{
        var result = format
        if !result.contains("."){
            result += ".0"
        }
        
        let expression = NSExpression(format: result)
        if let value = expression.expressionValue(with: nil, context: nil) as? Double{
            if value.truncatingRemainder(dividingBy: 1) == 0{
                //in decimal
                return String(String(value).dropLast(2)) 
            }else{
                //not decimal
                return String(value)
            }
        }else{
            return "Error"
        }
    }
    
}

//MARK: - Send Data to HistoryVC
extension ViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let historyVC = segue.destination as? HistoryVC
        // Pass the selected object to the new view controller.
        historyVC?.historyArray = history
    }
}
