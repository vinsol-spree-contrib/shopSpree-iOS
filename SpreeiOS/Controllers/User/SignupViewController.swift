//
//  SignUpViewController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 12/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit
import SwiftyJSON

class SignUpViewController: BaseViewController {

    var delegate: AuthenticationViewController?

    // Mark: - Outlets

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!

    // Mark: - Actions

    @IBAction func switchToSignInView(_ sender: UIButton) {
        delegate!.switchToSignInView(self)
    }

    @IBAction func signup(_ sender: UIButton) {
        UserApiClient.signup(requestData(), success: { json in
        }, failure: { apiError in
            self.showApiErrorAlert(apiError)
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        signInButton.layer.borderColor = UIColor.primary.cgColor
        signInButton.layer.borderWidth = 0.5
    }

    private

    func requestData() -> URLRequestParams{
        var data = URLRequestParams()

        data["user[full_name]"] = nameTextField.text! as AnyObject?
        data["user[email]"]     = emailTextField.text! as AnyObject?
        data["user[password]"]  = passwordTextField.text! as AnyObject?
        data["user[phone]"]     = phoneTextField.text! as AnyObject?

        return data
    }
}
