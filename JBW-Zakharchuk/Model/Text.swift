//
//  Text.swift
//  JBW-Zakharchuk
//
//  Created by Kateryna Zakharchuk on 3/1/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation

class Text {
    var text = String()
    var countChar = Dictionary<Character, Int>()
    var sortedKeys = Array<Character>()
    
    public func createDictionary() {
        for i in self.text {
            if (countChar.keys.contains(i) == false) {
                countChar[i] = 1
            } else {
                countChar[i]! += 1
            }
        }
    }
    
    public func sortDictionary() {
        self.sortedKeys = Array(self.countChar.keys).sorted(by: <)
    }
}
