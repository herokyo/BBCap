//
//  DataExt.swift
//  BBCap
//
//  Created by Le Van Lam on 4/28/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

extension Data {

    init(forResource name: String?, ofType ext: String?, on `class`: AnyObject) {
        let bundle = Bundle(for: type(of: `class`))
        guard let path = bundle.path(forResource: name, ofType: ext), let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError("File is not valid or unselecting target member ship")
        }
        self = data
    }
}
