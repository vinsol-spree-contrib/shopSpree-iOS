//
//  ForgotPasswordController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 24/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class ForgotPasswordController: BaseViewController {

    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var forgotPasswordView: UIView!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetPasswordButton: UIButton!


    @IBAction func resetPassword(_ sender: UIButton) {
        UserApiClient.forgotPassword(requestData(), success: { json in
                let message = json["message"].stringValue
                self.showApiSuccessAlert(message)
            }, failure: { apiError in
                self.showApiErrorAlert(apiError)
        })
    }

    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)

        modalPresentationStyle = .custom
        transitioningDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        forgotPasswordView.layer.cornerRadius = 7
        forgotPasswordView.layer.borderWidth = 0.5
        forgotPasswordView.layer.borderColor = UIColor.primary.cgColor
    }

    private

    func requestData() -> URLRequestParams {
        var data = URLRequestParams()

        data["email"] = emailTextField.text! as AnyObject?

        return data
    }
}

extension ForgotPasswordController: UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
