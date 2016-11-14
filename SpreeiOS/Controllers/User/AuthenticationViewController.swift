//
//  AuthenticationViewController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 31/08/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

protocol AuthenticationViewDelegate {
    func switchToSignInView(_ controller: BaseViewController)
    func switchToSignUpView(_ controller: BaseViewController)
}

class AuthenticationViewController: BaseViewController {

    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var signUpView: UIView!

    @IBAction func dismissView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        signInView.frame = centerPane()
        signUpView.frame = rightPane()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signIn" {
            if let controller = segue.destination as? SignInViewController {
                controller.delegate = self
            }
        } else if segue.identifier == "signUp" {
            if let controller = segue.destination as? SignUpViewController {
                controller.delegate = self
            }
        }
    }

    func leftPane() -> CGRect {
        return CGRect( x: -120, y: 64, width: view.bounds.width, height: view.bounds.height - topBarView.bounds.height )
    }

    func centerPane() -> CGRect {
        return CGRect( x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - topBarView.bounds.height )
    }

    func rightPane() -> CGRect {
        return CGRect( x: view.bounds.width, y: 64, width: view.bounds.width, height: view.bounds.height - topBarView.bounds.height )
    }
}

extension AuthenticationViewController: AuthenticationViewDelegate {
    func switchToSignInView(_ controller: BaseViewController) {
        UIView.animate(withDuration: 0.4, delay: 0, options: UIViewAnimationOptions(), animations: {
            self.signInView.frame = self.centerPane()
        }, completion: nil)

        UIView.animate(withDuration: 0.4, delay: 0, options: UIViewAnimationOptions(), animations: {
            self.signUpView.frame = self.rightPane()
        }, completion:  nil)
    }

    func switchToSignUpView(_ controller: BaseViewController) {
        UIView.animate(withDuration: 0.4, delay: 0, options: UIViewAnimationOptions(), animations: {
            self.signUpView.frame = self.centerPane()
        }, completion: nil)

        UIView.animate(withDuration: 0.4, delay: 0, options: UIViewAnimationOptions(), animations: {
            self.signInView.frame = self.leftPane()
        }, completion: nil)
    }
}
