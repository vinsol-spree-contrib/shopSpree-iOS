//
//  AddressFormViewController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 27/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class AddressFormViewController: BaseViewController {

    var address: Address?
    var inEditMode: Bool {
        return address != nil
    }

    var delegate: AddressesViewController?

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var address1TextField: UITextField!
    @IBOutlet weak var address2TextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!

    @IBAction func saveAddress(_ sender: UIButton) {
        if inEditMode {
            updateAddress()
        } else {
            addAddress()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fillOutFormWhileEditing()
    }

    private

    func fillOutFormWhileEditing() {
        if inEditMode {
            firstNameTextField.text = address?.firstName
            lastNameTextField.text = address?.lastName
            address1TextField.text = address?.address1
            address2TextField.text = address?.address2
            cityTextField.text = address?.city
            zipTextField.text = address?.zipcode
            phoneTextField.text = address?.phone
        }
    }

    func requestData() -> URLRequestParams {
        var data = URLRequestParams()

        data["address[firstname]"] = firstNameTextField.text! as AnyObject?
        data["address[lastname]"]  = lastNameTextField.text! as AnyObject?
        data["address[address1]"] = address1TextField.text! as AnyObject?
        data["address[address2]"] = address2TextField.text! as AnyObject?
        data["address[city]"] = cityTextField.text! as AnyObject?
        data["address[zipcode]"] = zipTextField.text! as AnyObject?
        data["address[phone]"] = phoneTextField.text! as AnyObject?
        data["address[country_id]"] = 105 as AnyObject?
        data["address[state_id]"] = 1400 as AnyObject?
        
        return data
    }
}

extension AddressFormViewController {
    func addAddress() {
        AddressApiClient.addAddress(requestData(), success: { address in
                self.delegate!.addressesView(self, didFinishAddingAddress: address)
                self.navigationController?.popViewController(animated: true)
            }, failure: { apiError in
                self.showApiErrorAlert(apiError)
        })
    }

    func updateAddress() {
        AddressApiClient.updateAddress(address!.id!, data: requestData(), success: { address in
                self.delegate!.addressesView(self, didFinishUpdatingAddress: address)
                self.navigationController?.popViewController(animated: true)
            }, failure: { apiError in
                self.showApiErrorAlert(apiError)
        })
    }
}
