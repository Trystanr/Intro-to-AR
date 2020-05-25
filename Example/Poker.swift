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
	var eval = Evaluator()
	
	func addCard(card: String) {
		if Cards.count < 7 {
			Cards.append(convertCard(card: card))
//			print(getEvaluation())
			if (Cards.count > 5) {
				print(getEvaluation())
			}
	} else {
			print("Attempted to add more than 7 cards to Cards array")
		}
	}
	
	func emptyCards() {
		Cards.removeAll()
	}
	
	func getCardsAsString() -> String {
		if Cards.count != 0 {
			
			var strCards = ""
			for card in Cards {
				strCards += card + ", "
			}
			
			strCards.removeLast(2)

			return strCards
		} else {
			return ""
		}
	}
	
	func getCardAtIndex(i: Int) -> String {
		return Cards[i]
	}
	
	private func convertCard(card: String) -> String {
		var convertedCard = card;
		
		convertedCard = convertedCard.replacingOccurrences(of: "Hearts", with: "♥")
		convertedCard = convertedCard.replacingOccurrences(of: "Spades", with: "♠")
		convertedCard = convertedCard.replacingOccurrences(of: "Clubs", with: "♣")
		convertedCard = convertedCard.replacingOccurrences(of: "Diamonds", with: "♦")
		
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
		if Cards.count > 1 {
			print(eval.evaluate(cards: Cards).name)
//			print(Cards)
			
//			["K♣", "A♦", "J♣", "3♣"]
//			print(eval.evaluate(cards: ["T♣", "J♣", "Q♣", "K♣", "A♣"]).name)
			
//			switch eval.evaluate(cards: Cards).name {
//			case RankName.OnePair:
//				return "One Pair"
//			case RankName.TwoPairs:
//				return "Two Pairs"
//			case RankName.ThreeOfAKind:
//				return "Three of a Kind"
//			case RankName.FourOfAKind:
//				return "Four of a Kind"
//			case RankName.HighCard:
//				return "High Card"
//			case RankName.Flush:
//				return "Flush"
//			case RankName.FullHouse:
//				return "Full House"
//			case RankName.Straight:
//				return "Straight"
//			case RankName.StraightFlush:
//				return "Straight Flush"
//			default:
//				return "No Hand"
//			}
			return "No Hand"
		} else {
			return "Not enough Cards"
		}
	}
}
