//
//  BannedWord.swift
//  DeutschTaboo
//
//  Created by Eric Klose on 6/16/17.
//  Copyright © 2017 Eric Klose. All rights reserved.
//

import Foundation

class BannedWord {
    
    private var _bwWord: String!
    private var _bwDifficulty: Int!
    private var _bwEnglishHint: String!
    
    var bwWord: String {
        return _bwWord
    }
    
    var bwDifficulty: Int {
        return _bwDifficulty
    }
    
    var bwEnglishHint: String {
        if _bwEnglishHint != nil {
            return _bwEnglishHint
        } else {
            return ""
        }
    }
    
    
    init(bannedWordDict: NSDictionary) {
        if bannedWordDict["bwWord"] != nil {
            self._bwWord = bannedWordDict["bwWord"] as? String
            print("BW = ", _bwWord)
        }
        
        if let bwDictDifficulty = bannedWordDict["bwDifficulty"] as? String {
            self._bwDifficulty = Int(bwDictDifficulty)
//            print("BW DIFF: ", bannedWordDict["bwDifficulty"], " ++ ", _bwDifficulty)
        }

        
        if let bwDictEnglish = bannedWordDict["bwEnglish"] as? String {
            self._bwEnglishHint = bwDictEnglish
//            print("BW ENGL ", bannedWordDict["bwEnglish"], " && ", _bwEnglishHint)
        }
        
    }
}
