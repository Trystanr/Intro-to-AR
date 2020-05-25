//
//  OverlayViewController.swift
//  ARKitCoreML
//
//  Created by Trystan Rivers on 2020/05/25.
//  Copyright © 2020 trystan. All rights reserved.
//

import UIKit

class OverlayViewOld: UIView {
	
	
	let XIB_NAME = "OverlayView"
	
	@IBOutlet var contentView: UIVisualEffectView!
	
	@IBOutlet var lblCards: UILabel!
	
	override init(frame: CGRect) {
		super.init(frame:frame)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	
	func commonInit() {
		Bundle.main.loadNibNamed(XIB_NAME, owner: self, options: nil)
		addSubview(contentView)
	}
	
	//	override func initialize() {
//		super.initialize()
//
//
//		let name = String(describing: type(of: self))
//		let nib = UINib(nibName: name, bundle: .main)
//		nib.instantiate(withOwner: self, options: nil)
//
//		self.addSubview(self.containerView)
//		self.containerView.translatesAutoresizingMaskIntoConstraints = false
//
//		NSLayoutConstraint.activate([
//			self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
//			self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//			self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//			self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
//		])
//	}
}

extension UIView {
	func fixInView(_ container: UIView!) -> Void {
		self.translatesAutoresizingMaskIntoConstraints = false
		self.frame = container.frame
		
		NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
		NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
		NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
		NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
		
	}
}
