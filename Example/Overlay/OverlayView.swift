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
	
	
	var pokerID = Poker()
	
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
//		lblCard.text = "Card: "+card
		pokerID.addCard(card: card)
		lblCard.text = pokerID.getCardsAsString()
//		lblHand.text = pokerID.getEvaluation()
	}
	
	func resetCards() {
		pokerID.emptyCards()
		lblHand.text = ""
		lblCard.text = "Scan a card"
	}

}
