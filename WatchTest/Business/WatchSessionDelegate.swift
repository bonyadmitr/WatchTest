//
//  WatchSessionDelegate.swift
//  WatchTest
//
//  Created by Yaroslav Bondar VironIT on 30.08.17.
//  Copyright © 2017 VironIT. All rights reserved.
//

import WatchConnectivity

@available(iOS 9.3, *)
class WatchSessionDelegate: NSObject {
    
    static let shared = WatchSessionDelegate()
    
    fileprivate var session: WCSession! {
        didSet {
            session.delegate = self
            session.activate()
        }
    }
    
    func setup() {
        if WCSession.isSupported() {
            session = WCSession.default()
        }
    }
}

extension WatchSessionDelegate: WCSessionDelegate {
    
    // MARK: Must
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("- activationDidCompleteWith", session, error ?? "error nil")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("- sessionDidBecomeInactive", session)
    }
    
    /// The session can be re-activated for the now selected watch using activateSession
    func sessionDidDeactivate(_ session: WCSession) {
        print("- sessionDidDeactivate", session)
        session.activate()
    }
    
    // MARK: Need
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any], replyHandler: @escaping ([String: Any]) -> Void) {
        
        if let newMessage = message["modifyMessage"] as? String {
            replyHandler(["modifyMessage": newMessage.appending(" from iOS")])
            
        } else if let _ = message["messages"] {
            replyHandler(["messages": DataStore.shared.messages])
        }
        
        /// need??
        //replyHandler([:])
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("- didReceiveApplicationContext", applicationContext)
    }
}
