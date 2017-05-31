//
//  GameSettingsVC.swift
//  DeutschTaboo
//
//  Created by Eric Klose on 5/23/17.
//  Copyright © 2017 Eric Klose. All rights reserved.
//

import UIKit

class GameSettingsVC: UIViewController {

    
    @IBOutlet weak var schwierigkeitLbl: UILabel!    
    @IBOutlet weak var schwierigkeitSlider: UISlider!
    @IBOutlet weak var zeitInput: UITextField!
    
    var schwierigkeit: Int!
    var roundTime: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        zeitInput.text = String(roundTime)
        schwierigkeitSlider.value = Float(schwierigkeit)
        schwierigkeitLbl.text = String(schwierigkeit)
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let selectedValue = Int(sender.value)
        schwierigkeitLbl.text = String(stringInterpolationSegment: selectedValue)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToGame" {
            if let playCardVC = segue.destination as? PlayCardVC {
                print("SEGUE:: ", self.schwierigkeit, " & Zeit: ", self.zeitInput)
                let newTime = self.zeitInput.text
                playCardVC.roundTime = Double(newTime!)
                playCardVC.schwierigkeit = Int(self.schwierigkeitSlider.value)
            }
        }
    }
    
    @IBAction func settingsGenauBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backToGame", sender: self)
    }    

}
