//
//  GenerateCard.swift
//  DeutschTaboo
//
//  Created by Eric Klose on 5/3/17.
//  Copyright © 2017 Eric Klose. All rights reserved.
//

import Foundation

class GameCard {
    
    private var _URL: String!
    private var _hauptWort: String!
    private var _verbotenList: [String]!
    
    var hauptWord: String {
        if _hauptWort == nil {
            _hauptWort = "Fehler"
        }
        return _hauptWort
    }
    
    var URL: String! {
        if _URL == nil {
            _URL = ""
        }
        return _URL
    }
    
    init(hauptWort: String) {
        self._hauptWort = hauptWort
    }
    

}


