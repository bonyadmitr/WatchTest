//
//  DataStore.swift
//  WatchTest
//
//  Created by Yaroslav Bondar VironIT on 30.08.17.
//  Copyright © 2017 VironIT. All rights reserved.
//

import Foundation

class DataStore {
    
    static var shared = DataStore()
    
    var messages: [String] = []
    
    init() {
        messages = ["qqq", "wwww", "123"]
    }
}
