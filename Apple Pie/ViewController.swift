//
//  ViewController.swift
//  Apple Pie
//
//  Created by student7 on 2/15/19.
//  Copyright © 2019 student7. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //create outlets
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //create array of list of words
    var listOfWords = ["buccaneer", "swift", "glorius", "incandescent", "bug", "program"]
    
    //define variables for game
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    } //end totalWins
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    } //end totalLosses
    
    //create new instance of game
    var currentGame: Game!
    
    //function for starting a new round
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
        
    } //end newRound()
    
    //function to update totalWins and totalLosses
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        }
        else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        }
        else {
            updateUI()
        }
    } //end updateGameState()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //start new round when application launches
        newRound()
    } //end viewDidLoad()

    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    } //end enableLetterButtons()
    
    //create action for every letter button
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    } //end buttonPressed
    
    //function for updating the UI for score info
    func updateUI() {
        var letters = [String]()
        //separate underscore for multiple letters
        for letter in currentGame.formattedWord.characters {
            letters.append(String(letter))
        } //end for letter in currentGame
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")

    } //end updateUI()
    
} //end ViewController

