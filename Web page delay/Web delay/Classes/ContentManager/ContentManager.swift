//
//  ContentManager.swift
//  Web delay
//
//  Created by SOROKIN Andrey on 17/10/2018.
//  Copyright © 2018 Andrey Sorokin. All rights reserved.
//

import Foundation

final class ContentManager {

    enum ContentError: Error {
        case invalidHost
    }

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
        let defaults = UserDefaults.standard
        return defaults.object(forKey: url.absoluteString) != nil
    }

    func add(host: String) throws {
        guard
            host.isEmpty == false,
            let url = URL(string: host),
            keys.contains(host) == false else {
            throw ContentError.invalidHost
        }
        let h = Host(host: url)
        if let json = try? JSONEncoder().encode(h) {
            keys.append(host)
            
            UserDefaults.standard.set(json, forKey: host)
        } else {
            throw ContentError.invalidHost
        }
    }

//    func url(for key: String) -> URL? {
//        let value = UserDefaults.standard.object(forKey: key)
//        guard let stringUrl = value as? String else {
//            assertionFailure("Not string")
//            return nil
//        }
//
//        return URL(string: stringUrl)
//    }

    func host(for key: String) -> Host? {
        if let hostData = UserDefaults.standard.data(forKey: key) {
            return try? JSONDecoder().decode(Host.self, from: hostData)
        }
        return nil
    }
}
