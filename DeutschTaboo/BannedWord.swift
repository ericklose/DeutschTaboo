//
//  BannedWord.swift
//  DeutschTaboo
//
//  Created by Eric Klose on 6/16/17.
//  Copyright © 2017 Eric Klose. All rights reserved.
//

import Foundation

class BannedWord {
    
    private var _bwId: Int!
    private var _bwWord: String!
    private var _bwDifficulty: Int!
    private var _bwEnglishHint: String!
    
    var bwId: Int {
        return _bwId
    }
    
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
        if let bannedDictId = bannedWordDict["bwID"] as? String {
            self._bwId = Int(bannedDictId)
        }
        
        if bannedWordDict["bwWord"] != nil {
            self._bwWord = bannedWordDict["bwWord"] as? String
        }
        
        if let bwDictDifficulty = bannedWordDict["bwDifficulty"] as? String {
            self._bwDifficulty = Int(bwDictDifficulty)
        }

        if let bwDictEnglish = bannedWordDict["bwEnglish"] as? String {
            self._bwEnglishHint = bwDictEnglish
        }
        
    }
}
