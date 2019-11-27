//
//  PushDefault.swift
//  FCMStarter
//
//  Created by wiz_Dan on 27/11/2019.
//  Copyright © 2019 wiz_Dan. All rights reserved.
//

import Foundation

class WizDefault {

    // MARK: Singleton
    static let shared = WizDefault()
    private init() {}

    private let defaults = UserDefaults.standard

    public var wizToken: String? {
        get {
            return defaults.object(forKey: "wizToken") as? String
        }
        set(token) {
            defaults.set(token, forKey: "wizToken")
        }
    }
    
    public var fcmToken: String? {
        get{
            return defaults.object(forKey: "fcmToken") as? String
        }set(token) {
            defaults.set(token, forKey: "fcmToken")
        }
    }

    public func reset() {
        defaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        defaults.synchronize()
    }
}
