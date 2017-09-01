//
//  PresentsController.swift
//  WatchTest
//
//  Created by Yaroslav Bondar VironIT on 29.08.17.
//  Copyright © 2017 VironIT. All rights reserved.
//

import WatchKit
import PassKit

class PresentsController: WKInterfaceController {
    
    @IBOutlet var mediaPlayerButton: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setupActions()
        setupMediaPlayer()
    }
    
    // MARK: - Alerts
    
    private var actions: [WKAlertAction] = []
    private var sideActions: [WKAlertAction] = []
    
    private func setupActions() {
        let okAction = WKAlertAction(title: "OK", style: .default) {
            print("OK")
        }
        let cancelAction = WKAlertAction(title: "Cancel", style: .cancel) {
            print("Cancel")
        }
        let deleteAction = WKAlertAction(title: "Delete", style: .destructive) {
            print("Delete")
        }
        
        actions = [okAction, deleteAction, cancelAction]
        sideActions = [okAction, cancelAction]
    }
    
    @IBAction func actionAlert() {
        presentAlert(withTitle: "Some title", message: "Some message", preferredStyle: .alert, actions: actions)
    }
    @IBAction func actionAlertSideBySide() {
        /// exactly two actions are needed for sideBySideButtonsAlert
        presentAlert(withTitle: "Some title", message: "Some message", preferredStyle: .sideBySideButtonsAlert, actions: sideActions)
    }
    
    @IBAction func actionActionSheet() {
        /// by default there is cancel button
        /// but add cancel action to handle it
        /// doesn't add buttons with style: .cancel to the list
        presentAlert(withTitle: "Some title", message: "Some message", preferredStyle: .actionSheet, actions: actions)
    }
    
    // MARK: - Media
    
    private func setupMediaPlayer() {
        if let url = recFileURL,
            !FileManager.default.fileExists(atPath: url.path) {
            mediaPlayerButton.setEnabled(false)
        }
    }
    
    /// watchOS 2.0
    /// nil if group identifier is not set in capabilities
    private var recFileURL: URL? {
        /// Must use a shared container
        /// replace with your own group identifier
        guard let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.vironit.WatchTest") else { return nil }
        return container.appendingPathComponent("rec.mp4")
    }
    
    @IBAction func actionMediaPlayer() {
        guard let url = recFileURL else { return print("recFileURL is nil") }
        
        let options: [String: Any] = [
            WKMediaPlayerControllerOptionsAutoplayKey: false, /// default true
            //WKMediaPlayerControllerOptionsStartTimeKey: 1,
            //WKMediaPlayerControllerOptionsVideoGravityKey: WKVideoGravity.resizeAspect, /// video resizing to fit
            //WKMediaPlayerControllerOptionsLoopsKey: true
        ]
        
        presentMediaPlayerController(with: url, options: options) { (didPlayToEnd, timePlayed, error) in
            /// When the didPlayToEnd parameter is false, you can use timePlayed property to determine when playback stopped
            /// You might use that value as the start time if you play the content again
            print(didPlayToEnd)
            print(timePlayed)
            print(error ?? "error is nil")
        }
    }
    
    @IBAction func actionAudioRecorder() {
        guard let url = recFileURL else { return print("recFileURL is nil") }
        
        let options: [String: Any] = [
            WKAudioRecorderControllerOptionsActionTitleKey: "MY ACTION", /// save button title
            //WKAudioRecorderControllerOptionsAlwaysShowActionTitleKey: true, /// hide time and show save button
            WKAudioRecorderControllerOptionsAutorecordKey: true,
            WKAudioRecorderControllerOptionsMaximumDurationKey: 10
        ]
        
        /// TODO: Simulator don't need. Check on device. need to add a "Privacy - Microphone Usage Description" entry in the info.plist file of your iOS app (not the WatchKit app).
        /// TODO: Check. working in background
        presentAudioRecorderController(withOutputURL: url, preset: .highQualityAudio, options: options) { (didSave, error) in
            print("didSave", didSave)
            if let err = error {
                print("- presentAudioRecorderController", err.localizedDescription)
            } else if didSave {
                self.mediaPlayerButton.setEnabled(true)
            }
        }
    }
    
    // MARK: - Others
    
    @IBAction func actionTextInput() {
        /// results is nil if cancelled
        presentTextInputController(withSuggestions: ["1", "2", "qwe"], allowedInputMode: .allowAnimatedEmoji) { (resultArray) in
            guard let result = resultArray, let text = result.first else {
                return print("nil, canceled")
            }
            print("result array", result)
            print("first", text)
        }
    }
    
    /// import PassKit
    @IBAction func actionAddPasses() {
        /// don't work
        //        let passes: [PKPass] = [] // PKPassLibrary().passes()
        //        presentAddPassesController(withPasses: passes) {
        //            
        //        }
    }
}
