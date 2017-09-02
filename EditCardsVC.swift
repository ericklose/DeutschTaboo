//
//  EditCardsVC.swift
//  DeutschTaboo
//
//  Created by Eric Klose on 6/22/17.
//  Copyright © 2017 Eric Klose. All rights reserved.
//

import UIKit

class EditCardsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var deckToEdit: BuildCardList!
    var gameSettings: GameSettings!
    var cardToEdit: PlayingCard!
    var bannedWords = [BannedWord]()
    var deckEditLanguage: String!
    var cardToSave = [String: Any]()
    var bannedWordDict = [String: String]()
    var activeTextField: UITextField?
    
    
    @IBOutlet weak var targetWord: UITextField!
    @IBOutlet weak var targetEnglish: UITextField!
    @IBOutlet weak var targetDifficulty: UITextField!
    
    @IBOutlet weak var editBannedWordsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editBannedWordsTable.delegate = self
        editBannedWordsTable.dataSource = self
        
        newCardToEdit()
    }

    //project summary - a timing issue is crippling many effects (need GCD?), needs to write to webserver, needs new cards 
    
    //PROJECT 1: MAKE TOP AREA DISPLAY POPULATE CORRECTLY
    //"Edit Cards" while time field is engaged causes crash due to main thread conflict but Genau! button works
    //PROJECT 2: ENABLE CREATING NEW CARDS
    //PROJECT 3: Don't double draw new cards (inbound segue and newCardToEdit())
    //PROJECT 4: POST TO SERVER
    //project 5: I suspect game round times are bad with Ints vs Floats
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 + cardToEdit.bannedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        for _ in indexPath {
            if (indexPath as NSIndexPath).row < cardToEdit.bannedWords.count {
                let bannedWord = cardToEdit.bannedWords[(indexPath as NSIndexPath).row]
                if let cell = editBannedWordsTable.dequeueReusableCell(withIdentifier: "editBannedCell") as? EditBannedCell {
                    cell.configureCell(bannedWord: bannedWord, cardToEdit: cardToEdit)
                    return cell
                } else {
                    return EditBannedCell()
                }
            } else {
                if let cell = editBannedWordsTable.dequeueReusableCell(withIdentifier: "editBannedCell") as? EditBannedCell {
                    cell.prepEmptyCell(cardToEdit: cardToEdit)
                    return cell
                }
            }
        }
        return EditBannedCell()
    }
    
    func newCardToEdit() {
        if deckToEdit.gameDeck.count > 0 {
            cardToEdit = deckToEdit.drawRandomCard()
            //I think this is trying to load the text before the card is drawn?
            targetWord.text = cardToEdit.targetWord
            targetEnglish.text = cardToEdit.englishHint
            targetDifficulty.text = "\(cardToEdit.targetDifficulty)"
            editBannedWordsTable.reloadData()
        }
    }
    
    @IBAction func createNewCard(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Haha, Guess What Doesn't Work Yet?", message: "...new cards, obviously", preferredStyle: .alert)
        let failure = UIAlertAction(title: "Bummer!", style: .cancel, handler: { (action) -> Void in
        })
        alertController.addAction(failure)
        present(alertController, animated: true, completion: nil)
    }
    
    func saveCard() {
        cardToSave = cardToEdit.jsonifyCard()
        
        if JSONSerialization.isValidJSONObject(cardToSave) {
            print("CARD is valid JSON")
        } else {
            print("FAILED!")
        }
    }
    
    @IBAction func editCardSaveButton(_ sender: UIButton) {
        saveCard()
        newCardToEdit()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToSettings" {
            if let gameSettingsVC = segue.destination as? GameSettingsVC {
                gameSettingsVC.gameSettings = gameSettings
            }
        }
    }
}
