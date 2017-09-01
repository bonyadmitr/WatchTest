//
//  ConnectivityController.swift
//  WatchTest
//
//  Created by Yaroslav Bondar VironIT on 30.08.17.
//  Copyright © 2017 VironIT. All rights reserved.
//

import WatchKit

/// WKInterfaceController.openParentApplication
/// watchOS 1 only. handle in handleWatchKitExtensionRequest in AppDelegate of iOS app


class ConnectivityController: WKInterfaceController {
    
    @IBOutlet var tableView: WKInterfaceTable!
    @IBOutlet var someLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        
    }
    
    override func didAppear() {
        WatchSessionDelegate.shared.messages { messages in
            if let mess = messages {
                self.setupTable(for: mess)
            } else {
                print("error WatchSessionDelegate.shared.messages")
            }   
        }
    }
    
    private func setupTable(for strings: [String]) {
        tableView.setNumberOfRows(strings.count, withRowType: "CountryRow")
        
        for i in 0 ..< strings.count {
            guard let row = tableView.rowController(at: i) as? CountryRow else { return }
            row.nameLabel.setText(strings[i])
        }
    }

    @IBAction func actionButton() {
        WatchSessionDelegate.shared.modify(message: "message") { newMessage in
            if let newMess = newMessage {
                self.someLabel.setText(newMess)
            } else {
                print("error WatchSessionDelegate.shared.modify")
            }
        }
    }
    
}
