//
//  MainController.swift
//  WatchTest
//
//  Created by Yaroslav Bondar VironIT on 31.08.17.
//  Copyright © 2017 VironIT. All rights reserved.
//

import WatchKit

class MainController: WKInterfaceController {
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
    }
    
    /// Not working modal segue to another storyboard to show paged controllers
    /// presentController(withName: "ibPages", context: nil) not working to
    @IBAction func actionShowPages() {
        let str = ["Hello", "World", "!"]
        let vcs = Array(repeating: "PagedController", count: str.count)
        presentController(withNames: vcs, contexts: str)
    }
}
