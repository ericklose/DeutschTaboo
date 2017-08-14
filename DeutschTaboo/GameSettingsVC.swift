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
    var schwierigkeit: Int!
    var roundTime: Int!
    var pickerDataSource = ["Deutsch", "Francais", "English"]
    var gesprach: String!
    var englishHintsOn: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gesprachPicker.dataSource = self
        self.gesprachPicker.delegate = self
        
        gesprachPicker.selectRow(pickerDataSource.index(of: gesprach)!, inComponent: 0, animated: true)
        englishHints.isOn = englishHintsOn
        zeitInput.text = String(roundTime)
        schwierigkeitSlider.value = Float(schwierigkeit)
        schwierigkeitLbl.text = String(schwierigkeit)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.gesprachPicker.reloadAllComponents()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let selectedValue = Int(sender.value)
        schwierigkeitLbl.text = String(stringInterpolationSegment: selectedValue)
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
        gesprach = pickerDataSource[row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToGame" {
            if let playCardVC = segue.destination as? PlayCardVC {
                let newTime = self.zeitInput.text
                playCardVC.roundTime = Double(newTime!)
                playCardVC.schwierigkeit = Int(self.schwierigkeitSlider.value)
                playCardVC.language = gesprach
                playCardVC.englishHints = englishHintsOn
            }
        } else if segue.identifier == "editCards" {
            if let editCardsVC = segue.destination as? EditCardsVC {
                print("segue actions card count: ", self.deckPrep.gameDeck.count)
                editCardsVC.deckEditLanguage = self.gesprach
                editCardsVC.deckToEdit = self.deckPrep
                editCardsVC.cardToEdit = self.deckPrep.drawRandomCard()
            }
        }
    }
    
    @IBAction func englishHintsToggle(_ sender: UISwitch) {
        englishHintsOn = englishHints.isOn
    }
    
    @IBAction func editCardsBtn(_ sender: Any) {
        self.deckPrep = BuildCardList.init(language: gesprach, difficulty: 5, englishHints: true, completed: {
            self.performSegue(withIdentifier: "editCards", sender: self)
        })
    }
    
    @IBAction func settingsGenauBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backToGame", sender: self)
    }
    
}
