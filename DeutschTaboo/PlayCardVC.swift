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
    @IBOutlet weak var aTeamScoreLbl: UILabel!
    @IBOutlet weak var bTeamScoreLbl: UILabel!
    @IBOutlet weak var timerDisplay: UILabel!
    
    var gameDeck: BuildCardList!
    var gameCard: Dictionary<String, [String]>!
    var scoreTeamA: Int = 0
    var scoreTeamB: Int = 0
    var activeTeam: Bool!
    var gameTimer: Timer!
    var roundTime: Double!
    var startTime = Date.timeIntervalSinceReferenceDate
    var schwierigkeit: Int!
    var activeCard: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if schwierigkeit == nil {
            schwierigkeit = 5
        }
        if roundTime == nil {
            roundTime = 90
        }
        
        activeTeam = true
        timerDisplay.text = String(Int(roundTime))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        prepToBegin()
        popStartAlert()
        
    }
    
    func prepToBegin() {
        
        aTeamScoreLbl.textColor = UIColor.black
        bTeamScoreLbl.textColor = UIColor.gray
        aTeamScoreLbl.font = UIFont.boldSystemFont(ofSize: 32)
        bTeamScoreLbl.font = UIFont.systemFont(ofSize: 18)
        scoreTeamA = 0
        scoreTeamB = 0
        activeTeam = true
        
        gameDeck = BuildCardList.init(difficulty: schwierigkeit)
        
    }
    
    func runTimer() {
        timerDisplay.text = String(Int(roundTime))
        startTime = Date.timeIntervalSinceReferenceDate
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountDown), userInfo: nil, repeats: true)
    }
    
    func updateCountDown() {
        let currentTime = Date.timeIntervalSinceReferenceDate
        let timeElapsed = (currentTime - startTime)
        if timeElapsed < roundTime {
            timerDisplay.text = String(Int((roundTime - timeElapsed).rounded()))
        } else {
            timerDisplay.text = "\(0)"
        }
        
        if timeElapsed >= roundTime {
            endRound(reason: "timeOut")
        }
    }
    
    func displayCard() {
        activeCard = gameDeck.randomCard
        print("ACTIVE: ", gameDeck.gameDeck[activeCard])
        hauptWort.text = activeCard
        verbotenList.text = ""
        
        if gameDeck.gameDeck.isEmpty {
            print("IS THIS A THING: ", gameDeck.gameDeck[activeCard])
        } else {
            for wordList in gameDeck.gameDeck[activeCard]! {
                verbotenList.text = verbotenList.text! + "\n \(wordList)"
            }
        }
        
        aTeamScoreLbl.text = "\(scoreTeamA)"
        bTeamScoreLbl.text = "\(scoreTeamB)"
    }
    
    func startRound() {
        
        displayCard()
        runTimer()
    }
    
    func endRound(reason: String) {
        activeTeam = !activeTeam
        timerDisplay.text = "\(0)"
        
        if activeTeam == true {
            aTeamScoreLbl.font = UIFont.boldSystemFont(ofSize: 32)
            bTeamScoreLbl.font = UIFont.systemFont(ofSize: 18)
            aTeamScoreLbl.textColor = UIColor.black
            bTeamScoreLbl.textColor = UIColor.gray
        } else {
            bTeamScoreLbl.font = UIFont.boldSystemFont(ofSize: 32)
            aTeamScoreLbl.font = UIFont.systemFont(ofSize: 18)
            aTeamScoreLbl.textColor = UIColor.gray
            bTeamScoreLbl.textColor = UIColor.black
        }
        
        gameTimer.invalidate()
        
        if reason == "timeOut" {
            let alertController = UIAlertController(title: "Runde Beendet", message: "gibt das Handy über", preferredStyle: .alert)
            let fertig = UIAlertAction(title: "Fertig & Weiter", style: .default, handler: { (action) -> Void in
                self.runTimer()
                self.removeCurrentCard(card: self.activeCard)
                self.displayCard()
            })
            let storen = UIAlertAction(title: "Spiele Ende", style: .default, handler: { (action) -> Void in
                self.prepToBegin()
                self.popStartAlert()
            })
            alertController.addAction(fertig)
            alertController.addAction(storen)
            present(alertController, animated: true, completion: nil)
        } else if reason == "cardsOut" {
            let alertController = UIAlertController(title: "Schluß", message: "Keine Karten Mehr", preferredStyle: .alert)
            let erneut = UIAlertAction(title: "Spiel Erneut", style: .default, handler: { (action) -> Void in
                self.prepToBegin()
                self.popStartAlert()
            })
            let spielEinzelheiten = UIAlertAction(title: "Wechseln Einzelheiten", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "spielSettings", sender: nil)
            })
            alertController.addAction(erneut)
            alertController.addAction(spielEinzelheiten)
            present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Fehler - Soll Nicht Sein", message: "Keine Ahnung Wie Du Hier Bist", preferredStyle: .alert)
            let erneut = UIAlertAction(title: "Spiel Erneut", style: .default, handler: { (action) -> Void in
                self.prepToBegin()
                self.startRound()
            })
            let spielEinzelheiten = UIAlertAction(title: "Wechseln Einzelheiten", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "spielSettings", sender: nil)
            })
            alertController.addAction(erneut)
            alertController.addAction(spielEinzelheiten)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func popStartAlert() {
        let alertController = UIAlertController(title: "Bereits Zu Beginn?", message: "", preferredStyle: .alert)
        let los = UIAlertAction(title: "Los!", style: .default, handler: { (action) -> Void in
            self.startRound()
        })
        let spielEinzelheiten = UIAlertAction(title: "Spiel Einzelheiten", style: .default, handler: { (action) -> Void in
            self.performSegue(withIdentifier: "spielSettings", sender: nil)
        })
        alertController.addAction(los)
        alertController.addAction(spielEinzelheiten)
        present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "spielSettings" {
            if let gameSettingsVC = segue.destination as? GameSettingsVC {
                gameSettingsVC.roundTime = Int(self.roundTime)
                gameSettingsVC.schwierigkeit = self.schwierigkeit
            }
        }
    }
    
    func removeCurrentCard(card: String!) {
        if gameDeck.gameDeck.count > 1 {
            gameDeck.removePlayedCard(card: card)
        } else {
            gameDeck.removePlayedCard(card: card)
            endRound(reason: "cardsOut")
        }
    }
    
    
    
    @IBAction func misserfolgGetippt(_ sender: UIButton) {
        
        if gameDeck.gameDeck.count > 0 {
            if activeTeam == true {
                scoreTeamA = scoreTeamA - 1
            } else {
                scoreTeamB = scoreTeamB - 1
            }
        }
        removeCurrentCard(card: activeCard)
        displayCard()
    }
    
    @IBAction func bestatigungGetippt(_ sender: UIButton) {
        
        if gameDeck.gameDeck.count > 0 {
            if activeTeam == true {
                scoreTeamA = scoreTeamA + 1
            } else {
                scoreTeamB = scoreTeamB + 1
            }
        }
        removeCurrentCard(card: activeCard)
        displayCard()
    }
    
}

