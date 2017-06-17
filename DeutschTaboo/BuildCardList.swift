//
//  BuildCardList.swift
//  DeutschTaboo
//
//  Created by Eric Klose on 5/3/17.
//  Copyright © 2017 Eric Klose. All rights reserved.
//

import UIKit
import Foundation

class BuildCardList {
    
    private var _gameDeck = [PlayingCard]()
    private var _jsonResults: NSArray?
    private var _randomCard: PlayingCard!
    
    var gameCard: PlayingCard!
    var hauptWortSet = Set<String>()
    
    var jsonResults: NSArray? {
        return _jsonResults
    }
    
    var gameDeck: [PlayingCard] {
        return _gameDeck
    }
    
    func drawRandomCard() -> PlayingCard {
        let randomIndex = arc4random_uniform(UInt32(_gameDeck.count))
        _randomCard = _gameDeck.remove(at: Int(randomIndex))
        return _randomCard
    }
    
    func purgeDeck() {
        _gameDeck.removeAll()
    }
    
    init(language: String, difficulty: Int, englishHints: Bool) {
        downloadData(language: language, completed: {
            self.parseJSON(difficulty: difficulty, englishHints: englishHints)
        })
        parseJSON(difficulty: difficulty, englishHints: englishHints)
    }
    
    func downloadData(language: String, completed: @escaping DownloadComplete) {
        let url = NSURL(string: "http://hollyanderic.com/TabooServer/cards2.php?language=\(language)")
        
        let request = NSMutableURLRequest(url: url! as URL)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data,response,error in
            guard error == nil && data != nil else
            {
                print("Error:",error ?? "Some Error Happened")
                return
            }
            
            let httpStatus = response as? HTTPURLResponse
            
            if httpStatus!.statusCode == 200
            {
                if data?.count != 0
                {
                    if let responseString = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSArray  {
                        self._jsonResults = responseString
                        
                    }
                }
            }
            completed()
        }
        task.resume()
    }
    
    func parseJSON(difficulty: Int, englishHints: Bool) {
        if let jsonItem = jsonResults {
            for jsonItem in jsonResults! {
                if let aCardDict = jsonItem as? NSDictionary {
                    if let twDictDifficulty = aCardDict["twDifficulty"] as? String {
                        if (Int(twDictDifficulty)! <= difficulty || Int(twDictDifficulty)! == 1) {
                            print("DICT ", aCardDict)
                            let addedCard = PlayingCard(aCardDict: aCardDict)
                            self._gameDeck.append(addedCard)
                        }
                    }
                }
            }
        }
    }
}
