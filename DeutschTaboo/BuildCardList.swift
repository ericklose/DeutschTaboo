//
//  BuildCardList.swift
//  DeutschTaboo
//
//  Created by Eric Klose on 5/3/17.
//  Copyright © 2017 Eric Klose. All rights reserved.
//

import Foundation

class BuildCardList {
    
    private var _URL: String!
    private var _gameDeck = [String: [String]]()
    
    var hauptWortSet = Set<String>()
    
    var gameDeck: Dictionary<String, [String]> {
        return _gameDeck
    }
    
    var URL: String! {
        if _URL == nil {
            _URL = "http://hollyanderic.com/TabooServer/cards.php"
        }
        return _URL
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
    
    init(difficulty: Int) {
        downloadData(difficulty: difficulty)
    }
    
    func removePlayedCard(card: String!) {
        _gameDeck.removeValue(forKey: card)
    }
    
    func downloadData(difficulty: Int) {
        let url = NSURL(string: URL)
        
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
                        for jsonItem in responseString {
                            if let extraArray = jsonItem as? NSDictionary {
                                let mainWord = extraArray["cdMain"] as! String
                                let mainDiff1 = extraArray["cdLevel"] as! String
                                let mainDiff2: Int = Int(mainDiff1)!
                                if mainDiff2 <= difficulty || mainDiff2 == 1 {
                                    self.hauptWortSet.insert(mainWord)
                                }
                            }
                        }
                        for eachHauptWort in self.hauptWortSet {
                            var tempHauptWortArray: [String] = []
                            for jsonItem in responseString {
                                if let eachCard = jsonItem as? NSDictionary {
                                    if eachCard["cdMain"] as! String == eachHauptWort {
                                        let hintDiff1 = eachCard["cdHintLevel"] as! String
                                        let hintDiff2: Int = Int(hintDiff1)!
                                        if hintDiff2 <= difficulty {
                                            let newHint = eachCard["cdHint"] as! String
                                            tempHauptWortArray.append(newHint)
                                        }
                                    }
                                }
                                self._gameDeck[eachHauptWort] = tempHauptWortArray
                            }
                        }
                    }
                }
            }
        }
        print("DECK STATUS: ", self._gameDeck)

        task.resume()
    }
    
}
