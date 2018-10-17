//
//  ContentManager.swift
//  Web delay
//
//  Created by SOROKIN Andrey on 17/10/2018.
//  Copyright © 2018 Andrey Sorokin. All rights reserved.
//

import Foundation

final class ContentManager {

    static let shared = ContentManager()

    private(set) var keys: [ String ] {
        get {
            guard let k = UserDefaults.standard.stringArray(forKey: "keys") else {
                return []
            }
            return k
        }

        set {
            UserDefaults.standard.set(newValue, forKey: "keys")
        }
    }

    func shouldDelay(url: URL) -> Bool {
        guard let host = url.host else {
            return false
        }
        let defaults = UserDefaults.standard
        return defaults.object(forKey: host) != nil
    }

    func add(host: String) {
        guard host.isEmpty == false else {
            return
        }
        keys.append(host)
        UserDefaults.standard.set(host, forKey: host)
    }
}
