//  ViewController.swift
//  Concentration
//
//  Created by CS193p Instructor  on 09/25/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
	
	private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
	
	var numberOfPairsOfCards: Int {
		 return (cardButtons.count + 1) / 2
	}
	
	private(set) var flipCount = 0 {
		didSet {
			 updateFlipCountLabel()
		}
	}
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)",
            attributes: attributes)
        
        flipCountLabel.attributedText = attributedString
    }
    
	@IBOutlet private weak var flipCountLabel: UILabel! {
		didSet {
			 updateFlipCountLabel()
		}
	}
	
	@IBOutlet private var cardButtons: [UIButton]!
	
	
	@IBAction private func touchCard(_ sender: UIButton) {
		flipCount += 1
		if let cardNumber = cardButtons.index(of: sender) {
			game.chooseCard(at: cardNumber)
			updateViewFromModel()
		} else {
			print("choosen card was not in cardButtons")
		}
	}
	
	private func updateViewFromModel() {
        if cardButtons != nil {
		for index in cardButtons.indices {
			let button = cardButtons[index]
			let card = game.cards[index]
			if card.isFaceUp {
				button.setTitle(emoji(for: card), for: UIControl.State.normal)
				button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
			} else {
				button.setTitle("", for: UIControl.State.normal)
				button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
			}
		}
        }
	}
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            // Creates empty dictionary. [:].. type for it is inferred
            emoji = [:]
            updateViewFromModel()
        }
    }
	private var emojiChoices = "🦇😱🙀😈🎃👻🍭🍬🍎"
	
	private var emoji = [Card: String]()
	
	private func emoji(for card: Card) -> String {
		if emoji[card] == nil, emojiChoices.count > 0 {
			let stringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4Random)
			emoji[card] = String(emojiChoices.remove(at: stringIndex))
		}
		return emoji[card] ?? "?"
	}
}

extension Int {
	var arc4Random: Int {
		switch self {
		case 1...Int.max:
			return Int(arc4random_uniform(UInt32(self)))
		case -Int.max..<0:
			return Int(arc4random_uniform(UInt32(self)))
		default:
			return 0
		}
		
	}
}














