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
    var cardToEdit: PlayingCard!
    //    var bannedWords = [BannedWord]()
    var deckEditLanguage: String!
    
    @IBOutlet weak var targetWord: UITextField!
    @IBOutlet weak var targetEnglish: UITextField!
    @IBOutlet weak var targetDifficulty: UITextField!
    
    @IBOutlet weak var editBannedWordsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editBannedWordsTable.delegate = self
        editBannedWordsTable.dataSource = self
        editBannedWordsTable.estimatedRowHeight = 100
        
        editBannedWordsTable.reloadData()
        
        cardToEdit = deckToEdit.drawRandomCard()
        
        if cardToEdit != nil {
            targetWord.text = cardToEdit.targetWord
            targetEnglish.text = cardToEdit.englishHint
            targetDifficulty.text = "\(cardToEdit.targetDifficulty)"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 //+ cardToEdit.bannedWords.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return editBannedWordsTable.estimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //       if let cell = editBannedWordsTable.dequeueReusableCell(withIdentifier: "editBannedCell") as? EditBannedCell {
        //n            print("banned : ", cardToEdit.bannedWords[0].bwWord)
        //            let bannedWord = cardToEdit.bannedWords[(indexPath as NSIndexPath).row]
        //            cell.configureCell(bannedWord: bannedWord)
        //            return cell
        //        } else {
        return EditBannedCell()
    }
    //    }
    
    
    @IBAction func editCardSaveButton(_ sender: UIButton) {
        if deckToEdit.gameDeck.count > 0 {
            cardToEdit = deckToEdit.drawRandomCard()
            targetWord.text = cardToEdit.targetWord
            targetEnglish.text = cardToEdit.englishHint
            //            targetDifficulty.text = "\(cardToEdit.targetDifficulty)"
            editBannedWordsTable.reloadData()
        }
    }
    
}
