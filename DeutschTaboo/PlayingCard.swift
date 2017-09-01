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
    private var _cardJson = [String:Any]()
    private var _bannedJson = [Any]()
    
    var cardId: Int {
        if _cardId != nil {
            return _cardId
        } else {
            return 0
        }
    }
    
    var targetWord: String {
        return _targetWord
    }
    
    var language: String {
        return _language
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
    
    func addBannedWord(newBannedDict: [String: Any]) {
        if let newTempDict = newBannedDict as? NSDictionary {
            _bannedWords.append(BannedWord(bannedWordDict: newTempDict))
        }
    }
    
    func addBannedWordOLD(newBannedWord: String) {
        if let newTempDict = ["bwWord": newBannedWord] as? NSDictionary {
            _bannedWords.append(BannedWord(bannedWordDict: newTempDict))
        }
    }
    
    func jsonifyCard() -> [String: Any] {
        _cardJson = ["twID": _cardId, "twWord": _targetWord, "twDifficulty": _targetDifficulty, "twLanguage": _language, "twEnglish": _englishHint]
        
        if _bannedWords.isEmpty {
            print("EMPTY BAN")
        } else {
            _bannedJson = []
            for ban in _bannedWords {
                let ban2 = ban.jsonifyBannedWord() as [String: Any]
                _bannedJson.append(ban2)
            }
            _cardJson["bannedWords"] = _bannedJson
        }
        
        print("JSON OUTPUT: ", _cardJson)
        return _cardJson
    }
    
}
