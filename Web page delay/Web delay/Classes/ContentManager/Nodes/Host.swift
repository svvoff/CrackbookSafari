//
//  Host.swift
//  Web delay
//
//  Created by SOROKIN Andrey on 23/12/2018.
//  Copyright © 2018 Andrey Sorokin. All rights reserved.
//

import Foundation

struct Host: Codable, Hashable {
    let host: URL
    var delay: TimeInterval = 20
    mutating func set(delay: TimeInterval) {
        self.delay = delay
    }

    init(host: URL, delay: TimeInterval = 20) {
        self.host = host
    }
}
