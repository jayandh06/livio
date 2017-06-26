//
//  PatientInfoViewController.swift
//  LivioHealth
//
//  Created by Jayandhan R on 6/20/17.
//  Copyright © 2017 Jayandhan R. All rights reserved.
//

import UIKit

class PatientInfoViewController: UIViewController {
 
    @IBOutlet weak var address1Text: UILabel!
    @IBOutlet weak var address2Text: UILabel!
    @IBOutlet weak var address3Text: UILabel!
    
    @IBOutlet weak var phoneText: UILabel!
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var insuranceCompanyText: UILabel!
    @IBOutlet weak var insuranceIDText: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    var contactInfo: NSDictionary = [:]
    
    
    override func viewDidLoad() {
        
        self.continueButton.backgroundColor = UIColor(hue: 0.5528, saturation: 1, brightness: 0.99, alpha: 1.0)
        self.continueButton.layer.cornerRadius = 5
        
        let contacts = self.contactInfo["Contacts"] as? NSDictionary
        let row = contacts?["row"] as? NSDictionary
        let fields = row?["FL"] as? [[String: String]]
        for field in fields! {
            print(field["val"]! +  " : " +  field["content"]!)
            if(field["val"] == "Email"){
                emailText.text = field["content"]
            }
            
            
            if(field["val"] == "Mailing Street") {
                address1Text.text = field["content"]
            }
            
            if(field["val"] == "Mailing City") {
                address2Text.text = field["content"]
            }
            
            if(field["val"] == "Mailing State") {
                address3Text.text = field["content"]
            }
            
            if(field["val"] == "Mailing Zip") {
                address3Text.text = field["content"]
            }
            
            if(field["val"] == "Insurance ID") {
                insuranceIDText.text = field["content"]
            }
            
            if(field["val"] == "Company") {
                insuranceCompanyText.text = field["content"]
            }
        }

        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
