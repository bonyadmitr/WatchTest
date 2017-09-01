//
//  InterfaceController.swift
//  WatchTest WatchKit Extension
//
//  Created by Yaroslav Bondar VironIT on 28.08.17.
//  Copyright © 2017 VironIT. All rights reserved.
//

import WatchKit

class InterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    
    let countries = ["Belgium", "USA", "UK", "India", "China", "Australia"]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        /// Configure interface objects here. Similar to the viewDidLoad in iOS
        setupTable()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func setupTable() {
        tableView.setNumberOfRows(countries.count, withRowType: "CountryRow")
        
        for i in 0 ..< countries.count {
            guard let row = tableView.rowController(at: i) as? CountryRow else { return }
            row.nameLabel.setText(countries[i])
        }
    }
    
    /// 1
//    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
//        pushController(withName: "DetailInterfaceController", context: countries[rowIndex])
//    }
    
    /// 2
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        if segueIdentifier == "details" {
            return countries[rowIndex]
        }
        return nil
    }
}
