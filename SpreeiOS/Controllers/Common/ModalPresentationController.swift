//
//  ModalPresentationController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 24/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class ModalPresentationController: UIPresentationController {

    lazy var overlayView = UIView(frame: CGRect.zero)

    override var shouldRemovePresentersView : Bool {
        return false
    }

    override func presentationTransitionWillBegin() {
        setupOverlayView()

        containerView!.insertSubview(overlayView, at: 0)

        if let transitioningCoordinator = presentedViewController.transitionCoordinator {
            transitioningCoordinator.animate(alongsideTransition: { _ in
                self.overlayView.alpha = 0.5
                }, completion: nil)
        }
    }

    override func dismissalTransitionWillBegin() {
        if let transitioningCoordinator = presentedViewController.transitionCoordinator {
            transitioningCoordinator.animate(alongsideTransition: { _ in
                self.overlayView.alpha = 0
                }, completion: nil)
        }
    }

    private

    func setupOverlayView() {
        overlayView.alpha = 0
        overlayView.frame = containerView!.bounds
        overlayView.backgroundColor = UIColor.lightGray

        let tap = UITapGestureRecognizer(target: self, action: #selector(ModalPresentationController.overlayViewTapped(_:)))
//        tap.cancelsTouchesInView = false
        overlayView.addGestureRecognizer(tap)
    }

    func overlayViewTapped(_ gesture: UIGestureRecognizer) {
        if (gesture.state == UIGestureRecognizerState.ended) {
            presentingViewController.dismiss(animated: true, completion: nil)
        }
    }
}
