//
//  GameSettingsVC.swift
//  DeutschTaboo
//
//  Created by Eric Klose on 5/23/17.
//  Copyright © 2017 Eric Klose. All rights reserved.
//

import UIKit

class GameSettingsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var schwierigkeitLbl: UILabel!
    @IBOutlet weak var schwierigkeitSlider: UISlider!
    @IBOutlet weak var zeitInput: UITextField!
    @IBOutlet weak var englishHints: UISwitch!
    @IBOutlet weak var gesprachPicker: UIPickerView!
    
    var deckPrep: BuildCardList!
    var gameSettings: GameSettings!
    var pickerDataSource = ["Deutsch", "Francais", "English"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gesprachPicker.dataSource = self
        self.gesprachPicker.delegate = self
        
        gesprachPicker.selectRow(pickerDataSource.index(of: gameSettings.language)!, inComponent: 0, animated: true)
        englishHints.isOn = gameSettings.englishHints
        zeitInput.text = String(gameSettings.gameTime)
        schwierigkeitSlider.value = Float(gameSettings.gameDifficulty)
        schwierigkeitLbl.text = String(gameSettings.gameDifficulty)
        
        print("SETTINGS: ", gameSettings.gameDifficulty, gameSettings.gameTime, gameSettings.englishHints)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.gesprachPicker.reloadAllComponents()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let selectedValue = Int(sender.value)
        schwierigkeitLbl.text = String(stringInterpolationSegment: selectedValue)
        gameSettings.changeDifficulty(newDifficulty: selectedValue)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let pickedLanguage = pickerDataSource[row]
        gameSettings.changeLanguage(newLanguage: pickedLanguage)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        updateTheTime()
        if segue.identifier == "backToGame" {
            if let playCardVC = segue.destination as? PlayCardVC {
                playCardVC.gameSettings = gameSettings
            }
        } else if segue.identifier == "editCards" {
            if let editCardsVC = segue.destination as? EditCardsVC {
                print("segue actions card count: ", self.deckPrep.gameDeck.count)
                editCardsVC.gameSettings = gameSettings
                editCardsVC.deckToEdit = self.deckPrep
                editCardsVC.cardToEdit = self.deckPrep.drawRandomCard()
            }
        }
    }

    func updateTheTime() {
        if let typedTime = self.zeitInput.text {
            if let newTime = Int(typedTime) {
                self.gameSettings.changeGameTime(newGameTime: newTime)
            }
        }
    }
    
    @IBAction func englishHintsToggle(_ sender: UISwitch) {
        let englishToggle = englishHints.isOn
        gameSettings.changeEnglish(englishHintStatus: englishToggle)
    }
    
    @IBAction func editCardsBtn(_ sender: Any) {
        self.deckPrep = BuildCardList.init(language: gameSettings.language, difficulty: 5, englishHints: true, completed: {
            self.performSegue(withIdentifier: "editCards", sender: self)
        })
    }
    
    @IBAction func settingsGenauBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backToGame", sender: self)
    }
    
}
