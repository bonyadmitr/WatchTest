//
//  NotificationController.swift
//  WatchTest WatchKit Extension
//
//  Created by Yaroslav Bondar VironIT on 28.08.17.
//  Copyright © 2017 VironIT. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications


/// images in IB must be in the Watch App Bundle
class NotificationController: WKUserNotificationInterfaceController {

    @IBOutlet var titleLabel: WKInterfaceLabel!
    @IBOutlet var bodyLabel: WKInterfaceLabel!
    
    override init() {
        // Initialize variables here.
        super.init()
        print("- NotificationController init")
        // Configure interface objects here.
    }

    // This method is called when watch view controller is about to be visible to user
    override func willActivate() {
        print("- NotificationController willActivate")
        super.willActivate()
    }

    // This method is called when watch view controller is no longer visible
    override func didDeactivate() {
        print("- NotificationController didDeactivate")
        super.didDeactivate()
    }
    
    /// need for dynamic notification
    // This method is called when a notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.
    override func didReceive(_ notification: UNNotification, withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Swift.Void) {
        print("- NotificationController didReceive notification", notification)
        let content = notification.request.content
        titleLabel.setText(content.title)
        bodyLabel.setText(content.body)
        completionHandler(.custom)
    }
}
