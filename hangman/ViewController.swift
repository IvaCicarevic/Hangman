//
//  ViewController.swift
//  hangman
//
//  Created by Iva Cicarevic on 3/7/19.
//  Copyright © 2019 Iva Cicarevic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
 var listOfWords = ["console", "source", "playground", "sidebar", "bool", "constant", "double", "function", "integer", "mutable", "property", "variable", "operator", "conditional", "switch", "compiler", "project", "storyboard", "target", "breakpoint", "bug", "exeption", "landscape", "portrait", "warning", "symbol", "action", "canvas", "outlet", "scene", "string", "structure", "class", "loop", "index", "literal", "range", "substring", "unicode", "parameter", "initializer", "intsance", "method", "property", "self", "type", "inheritance", "subclass", "superclass", "array", "dictionary", "button", "control", "picker", "label", "bar", "scroll", "slider", "view", "table", "toolbar", "clipping", "frame", "data", "gesture", "constraint", "sibling", "size", "nil", "optional", "any", "downcast", "casting", "inspection", "guard", "scope", "case", "default", "enum", "enumeration", "pop", "push", "segue", "root", "unwind", "badge", "item", "override", "state", "implementation", "navigation", "workflow", "hierarchy", "origin", "scene", "adopt", "codable", "comparable", "equatable", "implementation", "protocol", "active", "foreground", "abstraction", "architecture", "controller", "model", "bounds", "content", "dequeue", "dynamic", "custom", "row", "static", "plist", "sandboxing", "serialization", "unarchiving", "handler", "capture", "closure", "filter", "map", "reduce", "sorted", "mutate", "affine", "animation", "concatenate", "playground", "touch", "transform", "wireframe", "api", "asynchronous", "html", "http", "json", "post", "query", "url", "web", "concurrency", "dispatch", "backgorund", "network", "launch", "template", "default", "extent", "failable", "force", "image", "modulo"]
    
    let incorrectMovesAllowed = 10
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        DispatchQueue.main.async {
            self.imageStage.image = UIImage(named: "hangmanLoad.jpg")
        }
        
        listOfWords.shuffle()
        newRound()
        
    }
    
    @IBOutlet weak var imageStage: UIImageView!
    @IBOutlet weak var correctWord: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet var letters: [UIButton]!
    
    
    var currentGame: Game!
    
    
    
    @IBAction func buttons(_ sender: UIButton) {
        sender.isEnabled = false
        
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        
        
        updateGameState()
        
        print(currentGame.incorrectMovesRemaining)
        print(currentGame.formattedWord)
        
        
    }
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord,
                               incorrectMovesRemaining: incorrectMovesAllowed,
                               guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
            
        }
    }
    
    
    func updateUI() {
        
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        
        let wordWithSpacing = letters.joined(separator: " ")
        
        correctWord.text = wordWithSpacing
        score.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        imageStage.image = UIImage(named: "stage \(currentGame.incorrectMovesRemaining)")
        
       
        
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
            imageStage.image = UIImage(named: "sadSmile")
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
            imageStage.image = UIImage(named: "happySmile")
        } else {
            updateUI()
        }
        listOfWords.shuffle()
    }
    
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letters {
            button.isEnabled = enable
        }
    }
}
