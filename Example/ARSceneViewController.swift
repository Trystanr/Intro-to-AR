//
//  ARSceneViewController.swift
//  ARKitCoreML
//
//  Forked from Jason Clark.
//
//

import ARKit
import SceneKit
import UIKit 

final class ARSceneViewController: UIViewController {
	
	
    lazy var recognizer = MLRecognizer(
        model: DogCardClassifier2().model,
        sceneView: sceneView
    )

    let detectionImages = ARReferenceImage.referenceImages(
        inGroupNamed: "CardResource",
        bundle: nil
    )

    lazy var sceneView: ARSCNView = {
        let sceneView = ARSCNView()
        sceneView.delegate = self
        return sceneView
    }()

    lazy var refreshButton = UIBarButtonItem(
        barButtonSystemItem: .refresh,
        target: self, action: #selector(refreshButtonPressed)
    )
	
	lazy var overlay = OverlayView();
	
	
	let updateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! +
	".serialSceneKitQueue")

}

var activated = false;
var boxView = UIView()

extension ARSceneViewController {
	
	struct storedFunc {
		var activated = false
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        title = "ARPoker"
        navigationItem.rightBarButtonItem = refreshButton
		
//		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
		
//		sceneView.addGestureRecognizer(tapGesture)
        view.addSubview(sceneView)
		
		
//		let addedView = UINib(nibName: "OverlayView", bundle: .main).instantiate(withOwner: nil, options: nil).first as! UIView
//		addedView.frame = CGRect(
//			x: 20,
//			y: (view.bounds.height-addedView.bounds.height) - 40,
//			width: view.bounds.width - 40,
//			height: addedView.bounds.height
//		)
//		addedView.layer.cornerRadius = 5
//		addedView.layer.masksToBounds = true
//		view.addSubview(addedView)
		
		overlay.lblCard.text = "Scan a card"
		overlay.lblHand.text = ""
		
		overlay.frame = CGRect(
			x: 20,
			y: (view.bounds.height - 70 - 30),
			width: view.bounds.width - 40,
			height: 40
		)
		overlay.layer.cornerRadius = 5
		overlay.layer.masksToBounds = true
	
		
		view.addSubview(overlay)
		
        NSLayoutConstraint.activate([
            sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        view.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        resetTracking()
    }
	

	
	@objc
	func handleTap(_ gestureRecognize: UIGestureRecognizer) {
		let location = gestureRecognize.location(in: sceneView)
		let hitResults = sceneView.hitTest(location, options: [:])
		
		var angles = sceneView.projectPoint(hitResults[0].node.eulerAngles)
		boxView = UIView(frame: CGRect(x: location.x, y: location.y, width: 100, height: 40))
		boxView.backgroundColor = .red
		
		if !activated {
			if (hitResults.count > 0) {
				print("Tapped")
				print(hitResults[0].node)
				
				
				print(sceneView.projectPoint(hitResults[0].node.eulerAngles))
				
				sceneView.addSubview(boxView)
				
				UIView.animate(withDuration: 0.2) {
					boxView.frame = CGRect(x: self.sceneView.frame.width/2-150, y: self.sceneView.frame.height/2 - 100, width: 300, height: 200)
				}
				
				activated = true
			}
			
		} else {

		}
	}

    func resetTracking() {
        let config = ARWorldTrackingConfiguration()
        config.detectionImages = detectionImages
        config.maximumNumberOfTrackedImages = 1
        config.isLightEstimationEnabled = true
        config.isAutoFocusEnabled = true
        sceneView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
    }

}

extension ARSceneViewController: ARSCNViewDelegate {

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
		let referenceImage = imageAnchor.referenceImage
		
		let imageName = referenceImage.name ?? "undetected"
		
		updateQueue.async {
			self.addIndicatorPlane(to: imageAnchor)
			self.attachLabel(imageName, to: node)
		}

		DispatchQueue.main.async {
			self.overlay.addCard(card: imageName)
			
			UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
				self.overlay.frame.size.height = 160
				self.overlay.frame.origin.y = self.sceneView.frame.height - 200
			})
		}

//        addIndicatorPlane(to: imageAnchor)

        // send off anchor to be screenshot and classified
//        recognizer.classify(imageAnchor: imageAnchor) { [weak self] result in
//            if case .success(let classification) = result {
//
//                // update app with classification
//                self?.attachLabel(classification, to: node)
//				print(classification)
//			} else {
//				self?.attachLabel("failed", to: node)
//			}
//        }
    }

}

extension ARSceneViewController {

    /// Adds a plane atop `imageAnchor`
    func addIndicatorPlane(to imageAnchor: ARImageAnchor) {
        let node = sceneView.node(for: imageAnchor)
        let size = imageAnchor.referenceImage.physicalSize
        let geometry = SCNPlane(width: size.width, height: size.height)
        let plane = SCNNode(geometry: geometry)
        plane.geometry?.firstMaterial?.diffuse.contents = UIColor.white
		plane.geometry?.firstMaterial?.fillMode = .lines
        plane.eulerAngles.x = -.pi / 2
        node?.addChildNode(plane)
    }

    // Adds a label below `node`
    func attachLabel(_ title: String, to node: SCNNode) {
        let geometry = SCNText(string: title, extrusionDepth: 0)
        geometry.flatness = 0.1
        geometry.firstMaterial?.diffuse.contents = UIColor.white
        let text = SCNNode(geometry: geometry)
        text.scale = .init(0.00075, 0.00075, 0.00075)
        text.eulerAngles.x = -.pi / 2
        let box = text.boundingBox
        text.pivot.m41 = (box.max.x - box.min.x) / 2.0
        text.position.z = node.boundingBox.max.z + 0.012 // 1 cm below card
        node.addChildNode(text)
    }

}

extension ARSceneViewController {

    @objc func refreshButtonPressed() {
        resetTracking()
		self.overlay.resetCards()
		
		UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
			self.overlay.frame.origin.y = (self.view.bounds.height - 70 + 130)
			self.overlay.frame.size.height = 40
		}, completion: { _ in
			UIView.animate(withDuration: 0.2, animations: {
				self.overlay.frame.origin.y = (self.view.bounds.height - 70 - 30)
			})
		})
		
		
		
		
    }

}
