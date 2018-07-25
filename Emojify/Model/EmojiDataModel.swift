//
//  EmojiDataModel.swift
//  Emojify
//
//  Created by Vikas R S on 7/24/18.
//  Copyright © 2018 Vikas Radhakrishna Shetty. All rights reserved.
//

import UIKit

class EmojiDataModel
{
    //Declare your model variables here
    
    var result:Bool
    var code:Int
    var message :String
    var text:String
    
    
    // intialzer to give intial values to data models.
    init()
    {
        result = true
        code = 1
        message = ""
        text = ""
    }
    
}
