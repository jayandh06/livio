//
//  PatientLookupViewController.swift
//  LivioHealth
//
//  Created by Jayandhan R on 6/19/17.
//  Copyright © 2017 Jayandhan R. All rights reserved.
//

import UIKit

class PatientLookupViewController: UIViewController {
    

   
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var dateOfBirthText: UITextField!
    @IBOutlet weak var messageText: UILabel!

    var contactInfo: NSDictionary = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameText.text = "scott"
        lastNameText.text = "tiger"
        dateOfBirthText.text = "1975-01-01"
        
        messageText.text = ""
        
        //Set bordercolor for text fields
        let borderColor: UIColor = UIColor.lightGray
        
        self.firstNameText.layer.borderWidth = 1
        self.firstNameText.layer.borderColor = borderColor.cgColor
        
        self.lastNameText.layer.borderWidth = 1
        self.lastNameText.layer.borderColor = borderColor.cgColor
        
        self.dateOfBirthText.layer.borderWidth = 1
        self.dateOfBirthText.layer.borderColor = borderColor.cgColor
        
        
        self.searchButton.backgroundColor = UIColor(hue: 0.5528, saturation: 1, brightness: 0.99, alpha: 1.0)
        self.searchButton.layer.cornerRadius = 5
        searchButton.addTarget(self, action: #selector(searchPressed(sender:)), for: .touchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchPressed(sender: UIButton) {
        self.messageText.text = ""
      
        let urlString = "https://crm.zoho.com/crm/private/json/Contacts/searchRecords?authtoken=cc0e52e4b9a57a970d4e113dac784412&scope=crmapi&criteria=((Last Name:\(lastNameText.text ?? "")) AND (First Name:\(firstNameText.text ?? "")) AND (Date of Birth:\(dateOfBirthText.text ?? "")))"
        let escaped = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let url = URL(string: escaped!)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error ) in
            
            if error != nil {
                print("ERROR")
            }
            else {
                
                if let content = data {
                    do {
                        let responseJSON = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        //print(responseJSON)
                        if let response  = responseJSON["response"] as? NSDictionary {
                            if (response["nodata"] as? NSDictionary) != nil {
                                DispatchQueue.main.async {
                                    self.messageText.text = "Patient not found"
                                }
                                
                            }
                            else {
                                //print(response)
                                let result = response["result"] as? NSDictionary
                                self.contactInfo = result!
                                DispatchQueue.main.async {
                                    self.performSegue(withIdentifier: "patientInfoSegue", sender: self)
                                }
                                
                            }
                        }
                        
                    }
                    catch {
                        
                    }
                }
            }
    
        }
        task.resume()
   
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let patientInfoViewController = segue.destination as! PatientInfoViewController
        patientInfoViewController.contactInfo = self.contactInfo
    }
    
}
