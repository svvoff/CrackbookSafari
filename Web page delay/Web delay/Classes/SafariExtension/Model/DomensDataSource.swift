//
//  DomensDataSource.swift
//  Web delay
//
//  Created by SOROKIN Andrey on 25/10/2018.
//  Copyright © 2018 Andrey Sorokin. All rights reserved.
//

import Foundation

class DomenDataSource {
    weak var output: DomenDataSourceOutput?
    weak var contentManager: ContentManager! = ContentManager.shared
    private var keys: [ String ] {
        return ContentManager.shared.keys
    }
}

extension DomenDataSource: DomenDataSourceInput {
    func numberOfRows() -> Int {
        return keys.count + 1
    }

    func string(for row: Int) -> String {
        guard
            row < keys.count,
            let domen = contentManager.host(for: keys[row])?.host else {
                return ""
        }
        return domen.absoluteString
    }
}
