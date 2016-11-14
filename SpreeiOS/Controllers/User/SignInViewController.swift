//
//  AccountViewController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 12/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class SignInViewController: BaseViewController {

    var delegate: AuthenticationViewController?

    // Mark: - Outlets

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    // Mark: - Actions

    @IBAction func login(_ sender: UIButton) {
        UserApiClient.login(requestData(), success: { user in
            User.currentUser = user
            self.delegate?.dismiss(animated: true, completion: nil)
        }, failure: { apiError in
            self.showApiErrorAlert(apiError)
        })
    }

    @IBAction func switchToSignUpView(_ sender: UIButton) {
        delegate!.switchToSignUpView(self)
    }

    func forgotPassword(_ sender: UIButton) {
        performSegue(withIdentifier: "forgotPassword", sender: sender)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextField.rightView = forgotPasswordButton()
        passwordTextField.rightViewMode = .always

        signUpButton.layer.borderWidth = 0.5
        signUpButton.layer.borderColor = UIColor.primary.cgColor

//        enableLoginButton()
    }

    private

    func forgotPasswordButton() -> UIButton {
        let button = UIButton(type: .custom)

        button.setTitle("Forgot?", for: UIControlState())
        button.setTitleColor(UIColor.black, for: UIControlState())
        button.titleLabel!.font = UIFont(name: "Helvetica-Bold", size: 12)

        button.sizeToFit()
        button.frame.size.width += 20

        button.addTarget(self, action: #selector(forgotPassword(_:)), for: .touchUpInside)
        return button
    }

    func requestData() -> URLRequestParams {
        var data = URLRequestParams()

        data["user[email]"] = emailTextField.text! as AnyObject?
        data["user[password]"] = passwordTextField.text! as AnyObject?

        return data
    }

    func enableLoginButton() {
        let email = emailTextField.text!
        let password = passwordTextField.text!

        if email.isEmpty || password.isEmpty {
            signInButton.backgroundColor = UIColor.disabledColor
            signInButton.isUserInteractionEnabled = false
        } else {
            signInButton.backgroundColor = UIColor.primary
            signInButton.isUserInteractionEnabled = true
        }
    }

}


extension SignInViewController: UITextFieldDelegate {

//    func textFieldDidEndEditing(textField: UITextField) {
//        enableLoginButton()
//    }

}
