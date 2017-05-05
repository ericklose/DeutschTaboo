//
//  ViewController.swift
//  DeutschTaboo
//
//  Created by Eric Klose on 10/28/16.
//  Copyright © 2016 Eric Klose. All rights reserved.
//

import UIKit
import CoreData

class PlayCardVC: UIViewController {
    
    @IBOutlet weak var hauptWort: UILabel!
    @IBOutlet weak var verbotenList: UILabel!
    @IBOutlet weak var miserfolgBtn: UIButton!
    @IBOutlet weak var bestatigungBtn: UIButton!

    var gameDeck: BuildCardList!
    var gameCard: Dictionary<String, [String]>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameDeck = BuildCardList.init(difficulty: 0)
        
        hauptWort.text = gameDeck.gameDeck.keys.first
        print("contents: ", hauptWort)
        
//        hauptWort.text = hauptResult
        verbotenList.text = "x \n vier \n hallo \n der Hund \n etwas super extra langes"
        
    }



}

