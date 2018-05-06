//
//  ConverterViewController.swift
//  Conversion Calculator
//
//  Created by Bryan Yu on 04/12/18.
//  Copyright © 2018 Bryan Yu. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    var iText:String = ""
    var oText:String = ""
    var theConverter:Converter = Converter(label: "Fahrenheit to Celcius", input: "°F", output: "°C")

    let converters:[Converter] =
        [
        Converter(label: "Fahrenheit to Celcius", input: "°F", output: "°C"),
        Converter(label: "Celcius to Fahrenheit", input: "°C", output: "°F"),
        Converter(label: "Miles to Kilometers", input: "mi", output: "km"),
        Converter(label: "Kilometers to Miles", input: "km", output: "mi")
        ]

    @IBOutlet weak var outputDisplay: UITextField!
    
    @IBOutlet weak var inputDisplay: UITextField!
    
    @IBAction func buttonPress(_ sender: UIButton) {
        
        switch sender.tag{
        case 0:
            NumPressed(num: sender.titleLabel!.text!)
        case 1:
            ConvertPress()
        case 2:
            changeSign()
        case 3:
            decimal()
        case 4:
            clear()
        default:
            break
        }
        
    }
    
    func ConvertPress(){
        let popupAlert = UIAlertController(title: nil, message: "Choose Converter", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        for converter in converters{
            popupAlert.addAction(UIAlertAction(title: converter.label, style: UIAlertActionStyle.default, handler: {
                (alertAction) -> Void in
                self.theConverter = converter
                self.inputDisplay.text = self.iText + converter.input
                if let input = Double(self.iText){
                    self.oText = String(format: "%.2f", self.calculateConversion(input: input))
                }
                self.outputDisplay.text = self.oText + converter.output
                
            }
                )
            )
        }
        self.present(popupAlert, animated: true, completion: nil)
    }
    
    func NumPressed(num:String){
        iText.append(num)
        self.inputDisplay.text = iText + theConverter.input
        if let input = Double(iText){
            oText = String(format: "%.2f", calculateConversion(input: input))
        }
        self.outputDisplay.text = oText + theConverter.output
    }
    
    func calculateConversion(input:Double) -> Double {
        
        var output: Double = 0.0
        
        switch theConverter.label{
        case "Fahrenheit to Celcius":
            output = (input - 32) * (5/9)
        case "Celcius to Fahrenheit":
            output = input * (9/5) + 32
        case "Miles to Kilometers":
            output = input / 0.62137
        case "Kilometers to Miles":
            output = input * 0.62137
        default:
            break
        }
        return output
    }
    
    func changeSign() {
        if(!self.iText.isEmpty){
            if(self.iText.first != "-"){
                self.iText = "-" + self.iText
            }else{
                self.iText.remove(at: self.iText.index(of: "-")!)
            }
            self.oText = String(format: "%.2f", calculateConversion(input: Double(self.iText)!))
            self.inputDisplay.text = iText + theConverter.input
            self.outputDisplay.text = oText + theConverter.output
        }
        
       
    }
    
    func decimal() {
        if(!self.iText.contains(".") && self.iText.last != "."){
            self.iText.append(".")
            self.inputDisplay.text = iText + theConverter.input
            self.outputDisplay.text = oText + theConverter.output
        }
    }
    
    func clear(){
        self.iText = ""
        self.oText = ""
        self.inputDisplay.text = iText + theConverter.input
        self.outputDisplay.text = oText + theConverter.output
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
       
        
        let aConverter = converters[0]
        theConverter = aConverter
        inputDisplay.text = aConverter.input
        outputDisplay.text = aConverter.output
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
