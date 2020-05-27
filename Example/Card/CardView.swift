//
//  CardView.swift
//  ARPoker
//
//  Created by Trystan Rivers on 2020/05/26.
//  Copyright © 2020 trystan. All rights reserved.
//

import UIKit

class CardView: UIView {

	
	@IBOutlet var newContentView: UIView!
	
	@IBOutlet var newEffectView: UIVisualEffectView!
	
	@IBOutlet var newLblCard: UILabel!
	@IBOutlet var newLblCardBottom: UILabel!
	
	override init(frame: CGRect) {
		super.init(frame:frame)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		
		animate()
	}
	
	func setLabel(s: String) {
		newLblCard.text = s
		newLblCardBottom.text = s
		newLblCardBottom.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
	}
	
	func commonInit() {
		Bundle.main.loadNibNamed("NewCard", owner: self, options: nil)
		addSubview(newContentView)
		
		newEffectView.layer.cornerRadius = 5
		newEffectView.layer.masksToBounds = true
		
		newContentView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
		newContentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
	}

	func animate() {
		self.frame.origin.y = 100
		self.alpha = 0;
		
		UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseOut, animations: {
			self.frame.origin.y -= 100
			self.alpha = 100
		}, completion: nil)
	}
}
