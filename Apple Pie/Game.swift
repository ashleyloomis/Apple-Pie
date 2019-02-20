//
//  Game.swift
//  Apple Pie
//
//  Created by student7 on 2/16/19.
//  Copyright © 2019 student7. All rights reserved.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character] //keep track of letters player has guessed
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.characters.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    } //end playerGuessed
    
    //create word that hides missing letters
    var formattedWord: String {
        var guessedWord = ""
        for letter in word.characters {
            
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            } //end guessedLetters
            
        } //end for letter
        
        return guessedWord
        
    } //end formattedWord
    
} //end Game
