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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(bannedWord: BannedWord) {
        print("THIS IS INSIDE BANNED CELL")
        self.editBannedWordTextField.text = bannedWord.bwWord
        self.editBannedEnglishTextField.text = bannedWord.bwEnglishHint
        self.editBannedDifficulty.text = "\(bannedWord.bwDifficulty)"
    }
    
    func prepEmptyCell() {
        print("THIS IS AN EMPTY CELL")
    }

}
