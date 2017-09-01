//
//  UserNotificationCenterDelegate.swift
//  WatchTest
//
//  Created by Yaroslav Bondar VironIT on 29.08.17.
//  Copyright © 2017 VironIT. All rights reserved.
//


import UserNotifications

@available(watchOS 3.0, *)
class UserNotificationCenterDelegate: NSObject {
    static let shared = UserNotificationCenterDelegate()
    
    func setup() {
        UNUserNotificationCenter.current().delegate = self
    }
}

@available(watchOS 3.0, *)
extension UserNotificationCenterDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("- UserNotificationCenterDelegate userNotificationCenter willPresent", notification)
        completionHandler([.alert, .badge, .sound])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("- UserNotificationCenterDelegate userNotificationCenter didReceive", response)
        
        if response.actionIdentifier == "firstButtonAction" {
            print("- firstButtonAction pressed")
        }
        
        completionHandler()
    }
}
