//
//  TestFile.swift
//  HGDGDS-iOS
//
//  Created by Enes on 6/24/25.
//

import Foundation

struct A {
    var num = 0
}

struct B {
    var num: Int = 0
    
    func add(a: A) -> Int {
        a.num + num
    }
}
