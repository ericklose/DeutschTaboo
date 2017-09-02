//
//  EditBannedCell.swift
//  DeutschTaboo
//
//  Created by Eric Klose on 6/23/17.
//  Copyright © 2017 Eric Klose. All rights reserved.
//

import UIKit

class EditBannedCell: UITableViewCell {
    
    @IBOutlet weak var editBannedWordTextField: UITextField!
    @IBOutlet weak var editBannedEnglishTextField: UITextField!
    @IBOutlet weak var editBannedDifficulty: UITextField!
    
    var cardToEdit: PlayingCard!
    var bannedWord: BannedWord!
    var isNewBannedWord: Bool!
    var newBannedWord = [String: Any]()
    var newDifficulty: Int = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(bannedWord: BannedWord, cardToEdit: PlayingCard) {
        self.cardToEdit = cardToEdit
        print("THIS IS INSIDE BANNED CELL ID ", bannedWord.bwId, " WORD: ", bannedWord.bwWord, " DIFF: ", bannedWord.bwDifficulty, " ENGLIST: ", bannedWord.bwEnglishHint)
        self.isNewBannedWord = false
        self.bannedWord = bannedWord
        self.editBannedWordTextField.text = bannedWord.bwWord
        self.editBannedEnglishTextField.text = bannedWord.bwEnglishHint
        self.editBannedDifficulty.text = "\(bannedWord.bwDifficulty)"
    }
    
    func prepEmptyCell(cardToEdit: PlayingCard) {
        self.cardToEdit = cardToEdit
        print("THIS IS AN EMPTY CELL")
        self.isNewBannedWord = true
        self.editBannedWordTextField.text = ""
        self.editBannedEnglishTextField.text = ""
        self.editBannedDifficulty.text = ""
    }
    
    @IBAction func editBannedWord(_ sender: UITextField) {
        if let updatedBannedWord = editBannedWordTextField.text {
            if isNewBannedWord == false {
                bannedWord.editBannedWord(bannedWordEdit: updatedBannedWord)
            } else if isNewBannedWord == true && editBannedWordTextField.text != "" {
                newBannedWord["bwWord"] = updatedBannedWord
                cardToEdit.addBannedWord(newBannedDict: newBannedWord)
                self.bannedWord = cardToEdit.bannedWords.last
                newBannedWord = [:]
                isNewBannedWord = false
            }
        }
    }
    
    @IBAction func editBannedEnglishTranslation(_ sender: UITextField) {
        if let updateBannedEnglish = editBannedEnglishTextField.text {
            if isNewBannedWord == false {
                bannedWord.editBannedEnglishHint(bannedEnglishEdit: updateBannedEnglish)
            } else {
                newBannedWord["bwEnglish"] = updateBannedEnglish
            }
        }
    }
    
    @IBAction func editBannedDifficulty(_ sender: UITextField) {
        if let updateBannedDifficulty = editBannedDifficulty.text {
            if let intOfDifficulty = Int(updateBannedDifficulty) {
                if intOfDifficulty > 5 {
                    newDifficulty = 5
                } else if intOfDifficulty < 1 {
                    newDifficulty = 1
                } else {
                    newDifficulty = intOfDifficulty
                }
                if isNewBannedWord == false {
                    bannedWord.editBannedDifficulty(bannedDifficultyEdit: newDifficulty)
                } else {
                    newBannedWord["bwDifficulty"] = newDifficulty
                }
            }
        }
        editBannedDifficulty.text = "\(newDifficulty)"
    }
}
