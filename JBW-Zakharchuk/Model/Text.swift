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
    
    func createDictionary() {
        for i in self.text {
            if (countChar.keys.contains(i) == false) {
                countChar[i] = 1
            } else {
                countChar[i]! += 1
            }
        }
    }
    
    func sortDictionary() {
        self.sortedKeys = Array(self.countChar.keys).sorted(by: sortedBy)
    }
    
    private func sortedBy(_ first: Character, _ second: Character) -> Bool {
        switch compareTypes(firstChar: first, secondChar: second) {
        case true:
            if (first.asciiValue < second.asciiValue) {
                return true
            }
        case false:
            if (second.asciiValue < 65 || second.asciiValue > 122 ||
                (second.asciiValue >= 91 && second.asciiValue <= 96)) {
                return true
            }
        }
        return false
    }
    
    private func compareTypes(firstChar: Character, secondChar: Character) -> Bool {
        let letters = NSCharacterSet.letters
        var isItAlphaFirst = 0
        var isItAlphaSecond = 0
        
        for uni in firstChar.unicodeScalars {
            if (letters.contains(uni)) {
                isItAlphaFirst += 1
            }
        }
        for uni in secondChar.unicodeScalars {
            if (letters.contains(uni)) {
                isItAlphaSecond += 1            }
        }
        if (isItAlphaFirst == isItAlphaSecond) {
            return true
        }
        return false
    }
}

extension Character {
    var asciiValue: Int {
        get {
            let s = String(self).unicodeScalars
            return Int(s[s.startIndex].value)
        }
    }
}

