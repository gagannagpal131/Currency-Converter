//
//  ViewController.swift
//  Currency Converter
//
//  Created by Gagandeep Nagpal on 24/03/17.
//  Copyright © 2017 Gagandeep Nagpal. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate {
    
    
    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var pickerView1: UIPickerView!

    @IBOutlet weak var pickerView2: UIPickerView!
    
    @IBOutlet weak var outputText: UILabel!
    
    var inputCurrency = "None"
    var outputCurrency = "None"
    
    var Currency = ["None","USD","AUD","BGN","BRL","CAD","CHF","CNY","CZK","DKK","GBP","HKD","HRK","HUF","IDR","ILS","INR","JPY","KRW","MXN","MYR","NOK","NZD","PHP","PLN","RON","RUB","SEK","SGD","THB","TRY","ZAR","EUR"]
    
    @IBAction func getInfo(_ sender: Any) {
        
        if(inputCurrency == "None" || outputCurrency == "None" || inputText.text == "") {
            
            let alert = UIAlertController(title: "Please Enter Valid Inputs", message: "Please try again", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            self.outputText.text = ""

            
        }
        
        else{
        
        
        if let url = URL(string: "http://api.fixer.io/latest?base="+inputCurrency) {
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    
                    print(error ?? "none")
                    
                } else {
                    
                    if let urlContent = data {
                        
                        do {
                            
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                            
                            //print(jsonResult)
                            
                            var i = jsonResult["rates"] as? [String:Any]
                            
                            let j = i?[self.outputCurrency] as? Double
                            
                            //print (j ?? "NONE")
                    
                            
                            
                                DispatchQueue.main.sync(execute: {
                                    
                                 self.outputText.text = String(Double(j! * Double(self.inputText.text!)!))
                                    
                                })
                            
                            
                        
                            
                            
                        } catch {
                            
                            print("JSON Processing Failed")
                            
                        }
                        
                    }
                    
                    
                }
                
                
            }
            
            task.resume()
            
        } else {
            
            //COULD NOT FIND ANYTHING TRY AGAIN
            
        }
        
    }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.pickerView1.dataSource = self
        self.pickerView1.delegate = self
        
        self.pickerView2.dataSource = self
        self.pickerView2.delegate = self
        
        self.inputText.delegate = self
        
      
        
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
 
 
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView == pickerView1){
            //print(Currency[row])
            return Currency[row]

            
        }
            
        else if (pickerView == pickerView2){
            
            
            //print(Currency[row])
            return Currency[row]
            
            }
        
        return nil
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return Currency.count
        
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        
        if(pickerView == pickerView1){
            
            inputCurrency = Currency[row]
            
            print(inputCurrency)
            
        }
        else if(pickerView == pickerView2){
            
            outputCurrency =  Currency[row]
            print(outputCurrency)
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

