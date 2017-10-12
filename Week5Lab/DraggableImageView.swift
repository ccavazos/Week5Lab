//
//  DraggableImageView.swift
//  Week5Lab
//
//  Created by Cesar Cavazos on 10/11/17.
//  Copyright © 2017 Cesar Cavazos. All rights reserved.
//

import UIKit

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

class DraggableImageView: UIView {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var contentView: UIView!
    
    fileprivate var originalCenter: CGPoint!
    
    var image: UIImage? {
        get { return profileImageView.image }
        set { profileImageView.image = newValue }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubViews()
    }
    
    func initSubViews() {
        let nib = UINib(nibName: "DraggableImageView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    @IBAction func didPanProfile(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        let panStartedOn = sender.location(in: profileImageView)
        //let velocity = sender.velocity(in: self)
        
        if sender.state == .began {
            originalCenter = profileImageView.center
        } else if sender.state == .changed {
            // Move the image
            profileImageView.center = CGPoint(x: originalCenter.x + translation.x, y: profileImageView.center.y)
            // Rotate the image as well
            if panStartedOn.y > (profileImageView.bounds.height / 2) {
                profileImageView.transform = CGAffineTransform(rotationAngle: -translation.x.degreesToRadians)
            } else {
                profileImageView.transform = CGAffineTransform(rotationAngle: translation.x.degreesToRadians)
            }
        } else if sender.state == .ended {
            if translation.x > 50 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.profileImageView.center = CGPoint(x: 320, y: self.originalCenter.y)
                    self.profileImageView.alpha = 0
                })
            } else if translation.x < -50 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.profileImageView.center = CGPoint(x: -320, y: self.originalCenter.y)
                    self.profileImageView.alpha = 0
                })
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.profileImageView.center = CGPoint(x: self.originalCenter.x, y: self.originalCenter.y)
                    self.profileImageView.transform = CGAffineTransform.identity
                })
            }
            layoutIfNeeded()
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
