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
    
    
    //PROJECT 0: HAVE SAVE BUTTON SAVE EVEN IF USER HAS NOT UNSELECTED A FIELD
    //PROJECT 1: POST TO SERVER
    //PROJECT 2: MAKE TOP AREA DISPLAY POPULATE CORRECTLY
    //PROJECT 3: ENABLE CREATING NEW CARDS
    
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
            targetWord.text = cardToEdit.targetWord
            targetEnglish.text = cardToEdit.englishHint
            targetDifficulty.text = "\(cardToEdit.targetDifficulty)"
            editBannedWordsTable.reloadData()
        }
    }
    
    func saveCard() {
        cardToSave = cardToEdit.jsonifyCard()

        if JSONSerialization.isValidJSONObject(cardToSave) {
            print("CARD is valid JSON")
        } else {
            print("FAILED!")
        }
    }
    
    func postToServer(savedCard: PlayingCard) {
        
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        
        //let parameters = ["name": nametextField.text, "password": passwordTextField.text] as Dictionary<String, String>
        //let saveCard = savedCard as! NSDictionary
        
        print("STEP 1")
        let url = URL(string: "http://hollyanderic.com/TabooServer/cards2.php")!
        
        //create the session object
        let session = URLSession.shared
        print("STEP 2")
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        print("STEP 3")
        do {
            print("STEP 4")
            request.httpBody = try JSONSerialization.data(withJSONObject: saveCard, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            print("STEP 5")
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print("PASSED SERIALIAZATION: ", json)
                    // handle json...
                } else {
                    print("FAILED SERIALIZATION")
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    
    @IBAction func editCardSaveButton(_ sender: UIButton) {
        fakeField?.becomeFirstResponder()
        saveCard()
        newCardToEdit()
    }
}
