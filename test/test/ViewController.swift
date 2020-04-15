//
//  ViewController.swift
//  test
//
//  Created by student on 2020/3/30.
//  Copyright © 2020年 student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var emoji = [Int:String]()
    let emojiTheme = ["😇😡😵😫🤣😱😨😘","🍎🍐🍏🍊🍋🍌🍉🍇","⚽️🏀🏈⚾️🎾🏐🏉🎱","🚗🚕🚙🚌🚎🏎🚓🚑","❤️💛💚💙💜🖤💔💖","🇹🇼🇬🇹🇸🇿🇳🇪🇨🇦🇮🇨🇧🇸🇵🇾"]
    lazy var emojiChoices = emojiTheme[Int(arc4random_uniform(UInt32(6)))]
    var emojiDict = Dictionary<Card,String>()
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cards: [UIButton]!
    lazy var game = MatchingGame(numberOfPairsOfCards: (cards.count + 1) / 2 )
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        flips = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func emoji(for card: Card)->String{
        if emojiDict[card] == nil, emojiChoices.count > 0{
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy:emojiChoices.count.arc4random)
            emojiDict[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emojiDict[card] ?? "?"
    }
    
    var score = 0{
        didSet{
            scoreLabel.text = "score: \(score)"
        }
    }
    var flips = 0{
        didSet{
            //flipCounter.text = "Flips: \(flips)"
        }
    }
    @IBAction func filpCard(_ sender: UIButton) {
        print("f")
        if let cardNumber = cards.index(of: sender){
            score += game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("This card is not in the collection!")
        }
        flips+=1
    }
    
    
    @IBAction func startGame(_ sender: UIButton) {
        for index in cards.indices{
            cards[index].setTitle("", for: UIControlState.normal)
            cards[index].backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
            game = MatchingGame(numberOfPairsOfCards: (cards.count+1) / 2)
            emojiChoices = emojiTheme[Int(arc4random_uniform(UInt32(6)))]
        }
        score = 0
        //sender.setTitle("", for: UIControl.State.normal)
        //sender.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0)
    }
    
    func updateViewFromModel(){
        for index in cards.indices{
            let button = cards[index]
            var card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0.6965228873) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
}

extension Int{
    var arc4random:Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
    }
}
