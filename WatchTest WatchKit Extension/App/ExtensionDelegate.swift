//
//  ExtensionDelegate.swift
//  WatchTest WatchKit Extension
//
//  Created by Yaroslav Bondar VironIT on 28.08.17.
//  Copyright © 2017 VironIT. All rights reserved.
//

import WatchKit

/// Global tint effects to:
/// - back button title of push controllers (not modal)
/// - start controller title
/// - side by side default button style
/// - buttons colors in the TextInputController
/// - app name text color on notification launch (when it is displayed in the short look notification panel)

/// Notifications can only use the system font
/// To use custom fonts, you must install the fonts into both the Watch app bundle and the WatchKit extension bundle
/// - and add the UIAppFonts key to your Watch app’s Info.plist file
/// - for full info check Using Custom Fonts section in
/// - https://developer.apple.com/library/content/documentation/General/Conceptual/WatchKitProgrammingGuide/TextandLabels.html
/// - Avoid missing glyphs for custom fonts

/// watchOS stops gathering heart rate data when you begin playing media files or recording audio

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        print("- ExtensionDelegate applicationDidFinishLaunching")
        // Perform any final initialization of your application.
        
        setupNotifications()
        WatchSessionDelegate.shared.setup()
    }
    
    private func setupNotifications() {
        if #available(watchOSApplicationExtension 3.0, *) {
            UserNotificationCenterDelegate.shared.setup()
        } else {
            // Fallback on earlier versions
        }
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("- ExtensionDelegate applicationDidBecomeActive")
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
        print("- ExtensionDelegate applicationWillResignActive")
    }

    @available(watchOS 3.0, *)
    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        print("- ExtensionDelegate backgroundTasks", backgroundTasks)
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompleted()
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompleted()
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompleted()
            default:
                // make sure to complete unhandled task types
                task.setTaskCompleted()
            }
            
            // TODO: Check. maybe this line will be enough for WKSnapshotRefreshBackgroundTask
            //task.setTaskCompleted()
        }
    }

}
