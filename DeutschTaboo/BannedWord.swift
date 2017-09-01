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
    private var _bannedJson = [String:Any]()
    
    var bwId: Int {
        if _bwId != nil {
            return _bwId
        } else {
            return 0
        }
    }
    
    var bwWord: String {
        if _bwWord != nil {
            return _bwWord
        } else {
            return ""
        }
    }
    
    var bwDifficulty: Int {
        if _bwDifficulty != nil {
            return _bwDifficulty
        } else {
            return 1
        }
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
        } else {
            self._bwId = 0
        }
        
        if bannedWordDict["bwWord"] != nil {
            self._bwWord = bannedWordDict["bwWord"] as? String
        }
        
        if let bwDictDifficulty = bannedWordDict["bwDifficulty"] as? String {
            self._bwDifficulty = Int(bwDictDifficulty)
        } else {
            self._bwDifficulty = 1
        }
        
        if let bwDictEnglish = bannedWordDict["bwEnglish"] as? String {
            self._bwEnglishHint = bwDictEnglish
        } else {
            self._bwEnglishHint = ""
        }
        
    }
    
    func editBannedWord(bannedWordEdit: String) {
        _bwWord = bannedWordEdit
    }
    
    func editBannedEnglishHint(bannedEnglishEdit: String) {
        _bwEnglishHint = bannedEnglishEdit
    }
    
    func editBannedDifficulty(bannedDifficultyEdit: Int) {
        _bwDifficulty = bannedDifficultyEdit
    }
    
    func jsonifyBannedWord() -> [String: Any] {
        _bannedJson = ["bwID": _bwId, "bwWord": _bwWord, "bwDifficulty": _bwDifficulty, "bwEnglish": _bwEnglishHint]
        return _bannedJson
    }
    
}
