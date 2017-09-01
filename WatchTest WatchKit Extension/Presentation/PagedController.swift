//
//  PagedController.swift
//  WatchTest
//
//  Created by Yaroslav Bondar VironIT on 31.08.17.
//  Copyright © 2017 VironIT. All rights reserved.
//

import WatchKit

class PagedController: WKInterfaceController {
    
    @IBOutlet var label: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard let text = context as? String else { return }
        label.setText(text)
        
        /// will setup center controller but with animation
        if text == "World" {
            becomeCurrentPage()
        }
        
    }
}
