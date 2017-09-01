//
//  DetailInterfaceController.swift
//  WatchTest
//
//  Created by Yaroslav Bondar VironIT on 28.08.17.
//  Copyright © 2017 VironIT. All rights reserved.
//

import WatchKit
import Foundation

class DetailInterfaceController: WKInterfaceController {

    @IBOutlet weak var countryName: WKInterfaceLabel!
    @IBOutlet weak var capital: WKInterfaceLabel!
    @IBOutlet weak var currency: WKInterfaceLabel!
    @IBOutlet weak var flag: WKInterfaceImage!
    
    let capitals = ["Belgium":"Brussels 1234567890 1234567890 1234567890",
                    "USA":"Washington DC",
                    "UK":"London",
                    "India":"New Delhi",
                    "China":"Beijing",
                    "Australia":"Canberra"]
    
    let currencies = ["Belgium":"EUR",
                      "USA":"USD",
                      "UK":"GBP",
                      "India":"INR",
                      "China":"CNY",
                      "Australia":"AUD"]
    
    let flags = ["Belgium":"be",
                 "USA":"us",
                 "UK":"gb",
                 "India":"in",
                 "China":"cn",
                 "Australia":"au"]
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard let name = context as? String else { return }
        countryName.setText(name)
        capital.setText(capitals[name])
        currency.setText(currencies[name])
        
        /// Use the setImage:, setImageData:, setBackgroundImage:, or setBackgroundImageData: methods to transfer image data from your WatchKit extension to your Watch app
//        flag.setImage(UIImage(named:flags[name]!))
        
        /// Use the setImageNamed: or setBackgroundImageNamed: methods to assign an image that is already in the Watch app bundle
        flag.setImageNamed(flags[name])
    }
}
