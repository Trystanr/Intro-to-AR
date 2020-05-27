//
//  OverlayView.swift
//  ARKitCoreML
//
//  Created by Trystan Rivers on 2020/05/25.
//  Copyright © 2020 trystan. All rights reserved.
//

import UIKit

class OverlayView: UIView {

//	@IBOutlet var contentView: UIView!
	@IBOutlet var contentView: UIVisualEffectView!
	
	@IBOutlet weak var lblCard: UILabel!
	@IBOutlet weak var lblHand: UILabel!
	
	@IBOutlet var cardViewHolder: UIScrollView!
	
	var pokerID = Poker()
	
	
	var arrCards = [CardView]()
	
	override init(frame: CGRect) {
		super.init(frame:frame)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	
	func commonInit() {
		Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)
		addSubview(contentView)
		
		contentView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
		contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
	}
	
	func addCard(card: String) {
		pokerID.addCard(card: card)
		
		arrCards.append(CardView())
		arrCards.last?.setLabel(s: pokerID.getLastCardSuiteIcon())
		arrCards.last?.frame.origin.x = CGFloat(((arrCards.count-1) * 130))

		cardViewHolder.addSubview(arrCards.last!)
		
		cardViewHolder.contentSize = CGSize(width: (arrCards.count * 130)+10,height:50)
		
		if (arrCards.count > 2) {
			let leftOffset = CGPoint(x: cardViewHolder.contentSize.width - cardViewHolder.bounds.size.width, y: 0)
			cardViewHolder.setContentOffset(leftOffset, animated: true)
		}
		
		
		lblCard.text = pokerID.getCardsAsStringWithIcon()		
		lblHand.text = pokerID.getEvaluation()
	}
	
	
	func resetCards() {
		pokerID.emptyCards()
		lblHand.text = ""
		lblCard.text = "Scan a card"
		
		
		for sub in arrCards {
			sub.removeFromSuperview()
		}
		arrCards.removeAll()
		
	}

}
