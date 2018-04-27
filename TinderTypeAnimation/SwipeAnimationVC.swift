//
//  SwipeAnimationVC.swift
//  TinderTypeAnimation
//
//  Created by Apple on 27/04/18.
//  Copyright © 2018 Vignesh. All rights reserved.
//

import UIKit

class SwipeAnimationVC: UIViewController {

    // Outlet
    @IBOutlet weak var swipeView: UIView!
    
    // Variables
    private var animator: UIDynamicAnimator!
    private var snap: UISnapBehavior!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        snap = UISnapBehavior(item: swipeView, snapTo: view.center)
        animator.addBehavior(snap)
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pannedView))
        swipeView.addGestureRecognizer(panGesture)
        swipeView.isUserInteractionEnabled = true

    }
    
    @objc func pannedView(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
            
        case .began:
            animator.removeBehavior(snap)
        case .changed:
            let translation = recognizer.translation(in: view)
            swipeView.center = CGPoint(x: swipeView.center.x + translation.x , y: swipeView.center.y + translation.y)
            recognizer.setTranslation(.zero, in: view)
        case .ended, .failed, .cancelled:
            animator.addBehavior(snap)
        case .possible:
            break
        }
    }
}
