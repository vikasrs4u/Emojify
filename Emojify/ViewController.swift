//
//  ViewController.swift
//  Emojify
//
//  Created by Vikas R S on 7/24/18.
//  Copyright © 2018 Vikas Radhakrishna Shetty. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emojiTextField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.emojiTextField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // function to hide the keyboard on enter click
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    

}

