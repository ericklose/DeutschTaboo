//
//  GameSettings.swift
//  DeutschTaboo
//
//  Created by Eric Klose on 9/2/17.
//  Copyright © 2017 Eric Klose. All rights reserved.
//

import Foundation

class GameSettings {
    
    private var _language: String!
    private var _gameTime: Int!
    private var _englishHints: Bool!
    private var _gameDifficulty: Int!
    
    var language: String {
        if _language != nil {
            return _language
        } else {
            return "DE"
        }
    }
    
    var gameTime: Int {
        if _gameTime != nil {
            return _gameTime
        } else {
            return 60
        }
    }
    
    var gameDifficulty: Int {
        if _gameDifficulty != nil {
            return _gameDifficulty
        } else {
            return 5
        }
    }
    
    var englishHints: Bool {
        if _englishHints != nil {
            return _englishHints
        } else {
            return false
        }
    }
    
    init(initLanguage: String, initGameTime: Int, initGameDifficulty: Int, initEnglishHints: Bool) {
        self._language = initLanguage
        self._gameTime = initGameTime
        self._gameDifficulty = initGameDifficulty
        self._englishHints = initEnglishHints
    }
        
        func changeLanguage(newLanguage: String) {
            _language = newLanguage
        }
        
        func changeEnglish(englishHintStatus: Bool) {
            _englishHints = englishHintStatus
        }
        
        func changeDifficulty(newDifficulty: Int) {
            _gameDifficulty = newDifficulty
        }
        
        func changeGameTime(newGameTime: Int) {
            print("NEW GAME TIME: ", newGameTime)
            _gameTime = newGameTime
            print("other t: ", _gameTime)
        }
        
}
