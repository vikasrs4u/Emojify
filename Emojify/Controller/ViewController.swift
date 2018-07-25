//
//  ViewController.swift
//  Emojify
//
//  Created by Vikas R S on 7/24/18.
//  Copyright © 2018 Vikas Radhakrishna Shetty. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emojiTextField: UITextField!
    
    @IBOutlet weak var emojiOutputDataLabel: UILabel!
    
    //Constants
    let EMOJI_URL = "https://api.ritekit.com/v1/emoji/auto-emojify"
    let CLIENT_ID = "5a0a5e04524ee72f36743cd2e6116a6e2c3eb8aa144a"
    
    //Declare instance variables here
    let emojiDataModel = EmojiDataModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.emojiTextField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func emojifyButtonClicked(_ sender: UIButton)
    {
        self.emojiTextField.resignFirstResponder()
        
        let textEntered = emojiTextField.text!
        
        let params : [String:String] = ["text":textEntered, "client_id":CLIENT_ID]
        
        getEmojifyedData(url:EMOJI_URL , parameters: params)
        
        emojiOutputDataLabel.text = "Loading..."
        
    }
    // function to hide the keyboard on enter click
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - Networking
    /***************************************************************/
    
    func getEmojifyedData(url:String, parameters:[String:String])
    {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            if(response.result.isSuccess)
            {
                print("We are Succcessfully able to call the emoji service.")
                
                let emojiJSON :JSON = JSON(response.result.value!)
                
                self.updateEmojiData(jsonValue: emojiJSON)
  
            }
            
            if (response.result.isFailure)
            {
                print("Its a failure to call the emoji URL \(String(describing: response.result.error))")
                self.emojiOutputDataLabel.text = "Connection Error"
            }
        }
        
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateEmojiData(jsonValue:JSON)
    {
        // below Optional wrapping is required to avoid app crashing incase we get error code from the api call
        if (jsonValue["result"].boolValue)
        {
            emojiDataModel.text = jsonValue["text"].stringValue
            // below method will update all UI labels and image views
            updateUIWithEmojiData()
        }
        else
        {
            emojiOutputDataLabel.text = "Emoji Text Unavailable"
            
        }
        
    }
    
    //MARK: - UI Updates
    /***************************************************************/
    
    func updateUIWithEmojiData()
    {
        emojiOutputDataLabel.text = emojiDataModel.text
        
        UIPasteboard.general.string = emojiDataModel.text
        
        emojiTextField.text = ""

        let alertController = UIAlertController(title:"Emojifyed data is copied to the clipboard",message:nil,preferredStyle:.alert)
        self.present(alertController,animated:true,completion:{Timer.scheduledTimer(withTimeInterval: 2, repeats:false, block: {_ in
            self.dismiss(animated: true, completion: nil)
        })})
    }

}

