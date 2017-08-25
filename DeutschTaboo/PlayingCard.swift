//
//  PlayingCard.swift
//  DeutschTaboo
//
//  Created by Eric Klose on 6/8/17.
//  Copyright © 2017 Eric Klose. All rights reserved.
//

import Foundation

class PlayingCard {
    
    private var _targetWord: String!
    private var _bannedWords: [BannedWord] = []
    private var _targetDifficulty: Int!
    private var _language: String!
    private var _englishHint: String!
    private var _cardId: Int!
    
    var targetWord: String {
        return _targetWord
    }
    
    var language: String {
        return _language
    }
    
    var cardId: Int {
        if _cardId != nil {
            return _cardId
        } else {
            return 0
        }
    }
    
    var targetDifficulty: Int {
        if _targetDifficulty != nil {
            return Int(_targetDifficulty)
        } else {
            return 1
        }
    }
    
    var englishHint: String {
        if _englishHint != nil {
            return _englishHint
        } else {
            return ""
        }
    }
    
    var bannedWords: [BannedWord] {
        if _bannedWords.isEmpty {
            return []
        } else {
            return _bannedWords
        }
    }
    
    init(aCardDict: NSDictionary) {
        if let cardDictId = aCardDict["twID"] as? String {
            self._cardId = Int(cardDictId)
        }
        
        if aCardDict["twWord"] != nil {
            _targetWord = aCardDict["twWord"] as? String
        }
        
        if let cardDictDiff = aCardDict["twDifficulty"] as? String {
            self._targetDifficulty = Int(cardDictDiff)
        }
        
        if aCardDict["twLanguage"] != nil {
            _language = aCardDict["twLanguage"] as? String
        }
        
        if aCardDict["twEnglish"] != nil {
            _englishHint = aCardDict["twEnglish"] as? String
        }
        
        if let bannedWordsDict = aCardDict["bannedWords"] as? [NSDictionary] {
            for i in bannedWordsDict {
                if let _ = i["bwWord"] as? String {
                    _bannedWords.append(BannedWord(bannedWordDict: i))
                }
            }
        }
    }
    
}
