//
//  BuildCardList.swift
//  DeutschTaboo
//
//  Created by Eric Klose on 5/3/17.
//  Copyright © 2017 Eric Klose. All rights reserved.
//

import UIKit
import Foundation

class BuildCardList2 {
    
    private var _gameDeck = [String: [String]]()
    private var _jsonResults: NSArray?
    
    var hauptWortSet = Set<String>()
    
    var jsonResults: NSArray? {
        return _jsonResults
    }
    
    var gameDeck: Dictionary<String, [String]> {
        return _gameDeck
    }
    
    var randomCard: String {
        if gameDeck.count > 0 {
            let index: Int = Int(arc4random_uniform(UInt32(_gameDeck.count)))
            let key = Array(gameDeck.keys)[index]
            return key
        } else {
            return ""
        }
    }
    
    init(language: String, difficulty: Int, englishHints: Bool) {
        downloadData(language: language, completed: {
            self.parseJSON(difficulty: difficulty, englishHints: englishHints)
        })
        parseJSON(difficulty: difficulty, englishHints: englishHints)
    }
    
    func removePlayedCard(card: String!) {
        _gameDeck.removeValue(forKey: card)
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
        if let jsonItem = jsonResults as? NSArray {
            for jsonItem in jsonResults! {
                if let extraArray = jsonItem as? NSDictionary {
                    let mainDiff1 = extraArray["twDifficulty"] as! String
                    let mainDiff2: Int = Int(mainDiff1)!
                    if mainDiff2 <= difficulty || mainDiff2 == 1 {
                        if let mainWord = extraArray["twWord"] as? String {
                            if englishHints == true {
                                if let engHints = extraArray["twEnglish"] as? String {
                                    let newMain = mainWord + " // " + engHints
                                    self.hauptWortSet.insert(newMain)
                                }
                            } else {
                                let newMain = mainWord
                                self.hauptWortSet.insert(newMain)
                            }
                        }
                        for eachHauptWort in self.hauptWortSet {
                            var tempHauptWortArray: [String] = []
                            for jsonItem in jsonResults! {
                                if let eachCard = jsonItem as? NSDictionary {
                                    if eachCard["twWord"] as! String == eachHauptWort {
                                        if let hintDiff1 = eachCard["bwDifficulty"] as? String {
                                            let hintDiff2: Int = Int(hintDiff1)!
                                            if hintDiff2 <= difficulty {
                                                if let bannedWord = eachCard["bwWord"] as? String {
                                                    if englishHints == true {
                                                        if let engHints = eachCard["bwEnglish"] as? String {
                                                            let newHint = bannedWord + " // " + engHints
                                                            tempHauptWortArray.append(newHint)
                                                        }
                                                    } else {
                                                        let newHint = bannedWord
                                                        tempHauptWortArray.append(newHint)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            self._gameDeck[eachHauptWort] = tempHauptWortArray
                        }
                    }
                }
                //                print("DECK STATUS: ", self.gameDeck)
                //if self.gameDeck.count > 5 { break }
            }
        }
    }
    
}
