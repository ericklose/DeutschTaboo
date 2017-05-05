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
    //    private var _hauptWort: String!
    //    private var _verbotenList: [String]!
    private var _gameDeck: Dictionary<String, [String]>!
    
    
    var gameDeck: Dictionary<String, [String]> {
        if _gameDeck == nil {
            _gameDeck = ["der Hund": ["die Katze", "bestes Freund", "das Haustier", "der Wolf"], "die Sonne": ["der Stern", "der Himmel", "heiß", "feuer", "Atomkraft"]]
        }
        _gameDeck = ["die Frau": ["der Sex", "die Freundin", "Kocherin", "das Madchen"]]
        return _gameDeck
    }
    
    var URL: String! {
        if _URL == nil {
            _URL = "???"
        }
        return _URL
    }
    
    init(difficulty: Int) {
        //        Go fetch data from server

    }
    
    
    
    
    
    
    
    //    var hasherPrimaryHashName: String {
    //        if _hasherId == "-KFpS2L7kSm6oaUsC8Ss" {
    //            let wikiNameArray = [
    //                "Wikipediphilia",
    //                "Wikkipedaphilia",
    //                "Weekeepediphillia",
    //                "Wikipedifeelia",
    //                "Wikiipeedafelia",
    //                "Wikipedifilia",
    //                "Wickiepedddaphilia",
    //                "Wikipedipheliya"
    //            ]
    //            let randomIndex = Int(arc4random_uniform(UInt32(wikiNameArray.count)))
    //            return wikiNameArray[randomIndex]
    //        } else if _hasherPrimaryHashName != nil {
    //            return _hasherPrimaryHashName
    //        } else {
    //            return "Has no primary hash name"
    //        }
    //    }
    
    //    init (hasherInitId: String, hasherInitDict: Dictionary<String, AnyObject>) {
    //        self._hasherId = hasherInitId
    //
    //        if let hasherInitNerdName = hasherInitDict["hasherNerdName"] as? String {
    //            self._hasherNerdName = hasherInitNerdName
    //        }
    //
    //        if let hasherPrimaryHashName = hasherInitDict["hasherPrimaryHashName"] as? String {
    //            self._hasherPrimaryHashName = hasherPrimaryHashName
    //        }
    //
    //        if let hasherPrimaryKennel = hasherInitDict["hasherPrimaryKennel"] as? String {
    //            self._hasherPrimaryKennel = hasherPrimaryKennel
    //        }
    //
    //        self._hasherUrl = DataService.ds.REF_HASHERS.child(self.hasherId)
    //    }
    
    
    
    ////For future downloads
    //    func downloadWeatherForecast(completed: DownloadComplete) {
    //
    //        let url = NSURL(string: _URL)!
    //
    //        Alamofire.request(.GET, url).responseJSON { response in
    //            let result = response.result
    //
    //
    //            if let dict = result.value as? Dictionary<String, AnyObject> {
    //
    //                if let main = dict["main"] as? Dictionary<String, AnyObject> {
    //
    //                    if let temp = main["temp"] as? Double {
    //                        self._currentTemp = "\(temp)"
    //                        print("temp: \(self._currentTemp)")
    //                    }
    //
    //                }
    //
    //
    //                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
    //                    if let weatherIcon = weather[0]["id"] {
    //                        self._weatherIcon = "\(weatherIcon).png"
    //                        print("icon: \(self.weatherIcon)")
    //                    }
    //
    //                    if let description = weather[0]["description"] {
    //                        self._currentWeather = "\(description.capitalizedString)"
    //                        print("weather: \(self._currentWeather)")
    //                    }
    //                    if  weather.count > 1 {
    //                        for var x = 1; x < weather.count; x++ {
    //                            if let description = weather[x]["description"] {
    //                                self._currentWeather! += ", \(description.capitalizedString)"
    //                                print("weather: \(self._currentWeather)")
    //                            }
    //                        }
    //                    }
    //                }
    //            }
    //            completed()
    //            
    //            
    //            
    //        }
    //    }
}
