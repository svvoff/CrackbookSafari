//
//  DomenDataSourceIO.swift
//  Web delay
//
//  Created by SOROKIN Andrey on 25/10/2018.
//  Copyright © 2018 Andrey Sorokin. All rights reserved.
//

import Foundation

protocol DomenDataSourceInput: class {
    var output: DomenDataSourceOutput? { get set }

    func numberOfRows() -> Int

    func string(for row: Int) -> String
}

protocol DomenDataSourceOutput: class {

}
