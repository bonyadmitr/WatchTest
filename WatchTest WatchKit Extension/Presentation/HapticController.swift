//
//  HapticController.swift
//  WatchTest
//
//  Created by Yaroslav Bondar VironIT on 31.08.17.
//  Copyright © 2017 VironIT. All rights reserved.
//

import WatchKit

class HapticController: WKInterfaceController {
    
    @IBOutlet var tableView: WKInterfaceTable!
    
    let hapticTypes: [WKHapticType] = [.notification, .directionUp, .directionDown, .success, .failure, .retry, .start, .stop, .click]
    let hapticNames: [String] = ["notification", "directionUp", "directionDown", "success", "failure", "retry", "start", "stop", "click"]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setupTable()
    }
    
    private func setupTable() {
        tableView.setNumberOfRows(hapticTypes.count, withRowType: "CountryRow")
        
        for i in 0 ..< hapticTypes.count {
            guard let row = tableView.rowController(at: i) as? CountryRow else { return }
            row.nameLabel.setText("\(hapticNames[i])")
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        WKInterfaceDevice.current().play(hapticTypes[rowIndex])
    }
}

