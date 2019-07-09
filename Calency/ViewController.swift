//
//  ViewController.swift
//  Calency
//
//  Created by Vatsal Kulshreshtha on 09/07/19.
//  Copyright © 2019 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    
    let ADDITION:Character = "+"
    let SUBTRACTION:Character = "-"
    let DIVISION:Character = "/"
    let MULTIPLICATION:Character = "*"
    let EQUALS:Character = "="
    var MATH:Character = " "
    var val1:Double = Double.nan
    var val2:Double = 0.0
    var usdValue: Double = 0
    var euroValue: Double = 0
    var poundValue: Double = 0
    var usd:Double = 0
    var euro:Double = 0
    var gbp:Double = 0
    
    
    @IBOutlet weak var gbplabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var dispLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func numbers(_ sender: UIButton)
    {
        dispLabel.text = dispLabel.text! + String(sender.tag-1)
        
    }
    
    @IBAction func divide(_ sender: UIButton) {
        compute()
        MATH = DIVISION
        resultLabel.text = String(val1) + "/"
        dispLabel.text = ""
        
    }
    
    @IBAction func multiply(_ sender: UIButton) {
        compute()
        MATH = MULTIPLICATION
        resultLabel.text = String(val1) + "*"
        dispLabel.text = ""
    }
    
    @IBAction func add(_ sender: UIButton) {
      
        compute()
        MATH = ADDITION
        resultLabel.text = String(val1) + "+"
        dispLabel.text = ""
        
        
    }
    
    @IBAction func sub(_ sender: UIButton) {
        compute()
        MATH = SUBTRACTION
        resultLabel.text = String(val1) + "-"
        dispLabel.text = ""
    }
    
    @IBAction func equals(_ sender: UIButton) {
        compute()
        MATH = EQUALS
        resultLabel.text = resultLabel.text! + String(val2) + "=" + String(val1)
        dispLabel.text = ""
    }
    
    @IBAction func clear(_ sender: UIButton) {
        if (dispLabel.text?.count)! > 0{
            let tranculated = dispLabel.text?.substring(to: (dispLabel.text?.index(before: (dispLabel.text?.endIndex)!))!)
            dispLabel.text = tranculated
        }
        else{
            val1 = Double.nan
            val2 = Double.nan
            dispLabel.text = ""
            resultLabel.text = ""
            usdLabel.text = "USD"
            eurLabel.text = "EUR"
            gbplabel.text = "GBP"
        }
    }
    @IBAction func convertTapped(_ sender: UIButton) {
       
        
        usd = usdValue * Double(dispLabel.text!)!
        euro = euroValue * Double(dispLabel.text!)!
        gbp = poundValue * Double(dispLabel.text!)!
        usdLabel.text = String(round(1000*usd)/1000) + "$"
        eurLabel.text = String(round(1000*euro)/1000) + "€"
        gbplabel.text = String(round(1000*gbp)/1000) + "£"
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    getCurrency()
        
    }
    
    
   
    
    @IBAction func devButtonTapped(_ sender: Any) {
        showSafariVC(for: "https://github.com/vatsalkul")
    }
    func showSafariVC(for url: String){
        guard let url = URL(string: url) else {
            //show error
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    func compute(){
        if !val1.isNaN{
            val2 = Double(dispLabel.text!)!
            switch (MATH) {
            case ADDITION:
                val1 = val1 + val2
            case SUBTRACTION:
                val1 = val1 - val2
            case MULTIPLICATION:
                val1 = val1 * val2
            case DIVISION:
                val1 = val1 / val2
            case EQUALS:
                break
            default:
                print("Error")
            }
        }else {
            val1 = Double(dispLabel.text!)!
        }
       
    }
    
    func getCurrency()
    {
        
        let myLink:[String] = ["https://free.currconv.com/api/v7/convert?q=INR_USD&compact=ultra&apiKey=f89138db3cade42090a6", "https://free.currconv.com/api/v7/convert?q=INR_EUR&compact=ultra&apiKey=f89138db3cade42090a6", "https://free.currconv.com/api/v7/convert?q=INR_GBP&compact=ultra&apiKey=f89138db3cade42090a6"]
        for link in myLink{
            let url = URL(string: link)
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error != nil{
                    print("ERROR")
                }
                else{
                    if let content = data{
                        do{
                            if link == myLink[0]{
                                let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                                
                                if let ratesusd = myJson["INR_USD"] as? Double{
                                    self.usdValue = ratesusd
                                }
                            }
                            else if link == myLink[1]{
                                let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                                
                                if let rateseuro = myJson["INR_EUR"] as? Double{
                                    self.euroValue = rateseuro
                                }
                            }
                            else if link == myLink[2]{
                                let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                                
                                if let ratespound = myJson["INR_GBP"] as? Double{
                                    self.poundValue = ratespound
                                }
                            }
                            
                            
                        }
                        catch{
                            
                        }
                    }
                }
                }
                .resume()
            
            
            
        }
    }
    
}

