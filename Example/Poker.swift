//
//  Poker.swift
//  ARKitCoreML
//
//  Created by Trystan Rivers on 2020/05/25.
//  Copyright © 2020 trystan. All rights reserved.
//

import Foundation

class Poker {
	var Cards = [String]()
	
	func addCard(card: String) {
		if Cards.count < 7 {
			Cards.append(convertCard(card: card))
			
			if (Cards.count > 5) {
				// Evaluate 5 Hander
			}
	} else {
			print("Attempted to add more than 7 cards to Cards array")
		}
	}
	
	func emptyCards() {
		Cards.removeAll()
	}
	
	func getCardCount() -> Int {
		return Cards.count
	}
	
	func getCardsAsString() -> String {
		if Cards.count != 0 {
			
			var strCards = ""
			for card in Cards {
				strCards += card + " "
			}
			
			strCards.removeLast(1)

			return strCards
		} else {
			return ""
		}
	}
	
	func getCardsAsStringWithIcon() -> String {
		var cardsWithIcon = getCardsAsString()
		
		cardsWithIcon = cardsWithIcon.replacingOccurrences(of: "H", with: "♥")
		cardsWithIcon = cardsWithIcon.replacingOccurrences(of: "S", with: "♠")
		cardsWithIcon = cardsWithIcon.replacingOccurrences(of: "C", with: "♣")
		cardsWithIcon = cardsWithIcon.replacingOccurrences(of: "D", with: "♦")
		
		return cardsWithIcon
	}
	
	func getLastCardAsString() -> String {
			return Cards.last ?? ""
	}
	
	func getLastCardSuiteAsString() -> String {
			return Cards.last ?? ""
	}
	
	func getCardAtIndex(i: Int) -> String {
		return Cards[i]
	}
	
	func getLastCardSuiteIcon() -> String {
		var convertedCard = Cards.last;
	
		convertedCard = convertedCard!.replacingOccurrences(of: "H", with: "♥")
		convertedCard = convertedCard!.replacingOccurrences(of: "S", with: "♠")
		convertedCard = convertedCard!.replacingOccurrences(of: "C", with: "♣")
		convertedCard = convertedCard!.replacingOccurrences(of: "D", with: "♦")
		
		let index = convertedCard!.index(convertedCard!.startIndex, offsetBy: 1)
				
		print(String(convertedCard![index])
)
		
		return convertedCard!
	}
	
	private func convertCard(card: String) -> String {
		var convertedCard = card;
		
		convertedCard = convertedCard.replacingOccurrences(of: "Hearts", with: "H")
		convertedCard = convertedCard.replacingOccurrences(of: "Spades", with: "S")
		convertedCard = convertedCard.replacingOccurrences(of: "Clubs", with: "C")
		convertedCard = convertedCard.replacingOccurrences(of: "Diamonds", with: "D")
		
		convertedCard = convertedCard.replacingOccurrences(of: "Ace", with: "A")
		convertedCard = convertedCard.replacingOccurrences(of: "Two", with: "2")
		convertedCard = convertedCard.replacingOccurrences(of: "Three", with: "3")
		convertedCard = convertedCard.replacingOccurrences(of: "Four", with: "4")
		convertedCard = convertedCard.replacingOccurrences(of: "Five", with: "5")
		convertedCard = convertedCard.replacingOccurrences(of: "Six", with: "6")
		convertedCard = convertedCard.replacingOccurrences(of: "Seven", with: "7")
		convertedCard = convertedCard.replacingOccurrences(of: "Eight", with: "8")
		convertedCard = convertedCard.replacingOccurrences(of: "Nine", with: "9")
		convertedCard = convertedCard.replacingOccurrences(of: "Ten", with: "T")
		convertedCard = convertedCard.replacingOccurrences(of: "Jack", with: "J")
		convertedCard = convertedCard.replacingOccurrences(of: "Queen", with: "Q")
		convertedCard = convertedCard.replacingOccurrences(of: "King", with: "K")
		
		return convertedCard
	}
	
	func getEvaluation() -> String {
		if Cards.count == 4 {
			return "Needs 1 More Card"
		} else if Cards.count == 5 {
			let SF = BCUtility.makeCardArray(from: getCardsAsString())!
			return BCHand5.init(cards: SF)?.category.description ?? "Error"
		} else if Cards.count == 6 {
			return "Needs 1 More Card"
		} else if Cards.count == 7 {
			let SF = BCUtility.makeCardArray(from: getCardsAsString())!
			return BCHand7.init(cards: SF)?.category.description ?? "Error"
		} else {
			return "Needs " + String(5-Cards.count) + " More Cards"
		}
	}
	
	
}
