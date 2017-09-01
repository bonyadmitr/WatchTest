//
//  WatchSessionDelegate.swift
//  WatchTest
//
//  Created by Yaroslav Bondar VironIT on 30.08.17.
//  Copyright © 2017 VironIT. All rights reserved.
//

import WatchConnectivity

@available(watchOS 2.2, *)
class WatchSessionDelegate: NSObject {
    
    static let shared = WatchSessionDelegate()
    
    private var session: WCSession! {
        didSet {
            session.delegate = self
            session.activate()
        }
    }
    
    func setup() {
        /// Session is always available on WatchOS. WCSession.isSupported() doen't need
        session = WCSession.default()
    }
    
    func modify(message: String, handler: @escaping (String?) -> Void) {
        session.sendMessage(["modifyMessage": message], replyHandler: { response in
            handler(response["modifyMessage"] as? String)
        }, errorHandler: { error -> Void in
            print(error)
            handler(nil)
        })
    }
    
    func messages(handler: @escaping ([String]?) -> Void) {
        session.sendMessage(["messages": 0], replyHandler: { response in
            handler(response["messages"] as? [String])
        }, errorHandler: { error -> Void in
            print(error)
            handler(nil)
        })
    }
}

extension WatchSessionDelegate: WCSessionDelegate {
    
    // MARK: Must
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("- activationDidCompleteWith", session, activationState, error ?? "error nil")
    }
}
