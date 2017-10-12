//
//  CardsViewController.swift
//  Week5Lab
//
//  Created by Cesar Cavazos on 10/11/17.
//  Copyright © 2017 Cesar Cavazos. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool = true
    
    @IBOutlet var profileReusableView: DraggableImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileReusableView.image = UIImage(named: "Ryan")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapOnCard(_ sender: UITapGestureRecognizer) {
        let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileVC.image = profileReusableView.image
        profileVC.modalPresentationStyle = .custom
        profileVC.transitioningDelegate = self
        self.present(profileVC, animated: true, completion: nil)
    }
    
    // MARK: Transition Delegate Methods
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: .to)!
        let fromViewController = transitionContext.viewController(forKey: .from)!
        
        if isPresenting {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animate(withDuration: 0.4, animations: {
                toViewController.view.alpha = 1
            }, completion: { (finished: Bool) in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                fromViewController.view.alpha = 0
            }, completion: { (finished: Bool) in
                transitionContext.completeTransition(true)
                fromViewController.view.removeFromSuperview()
            })
        }
    }
}

