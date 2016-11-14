//
//  UserProfileViewController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 31/08/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    var datePickerVisible = false

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dobTextfield: UITextField!
    @IBOutlet weak var emailTextField: UIReadOnlyTextField!
    @IBOutlet weak var phoneTextField: UITextField!

    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerToolbar: UIToolbar!

    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var maleImage: UIButton!
    @IBOutlet weak var femaleImage: UIButton!

    @IBAction func dateChanged(_ sender: UIDatePicker) {
        let date = datePicker.date
        let formatter = DateFormatter()

        formatter.dateFormat = "dd-MMM-yyyy"

        let formattedDate = formatter.string(from: date)

        dobTextfield.text = formattedDate
    }

    @IBAction func clearSelectedDate(_ sender: UIBarButtonItem) {
        dobTextfield.text = ""
    }

    @IBAction func selectedDate(_ sender: UIBarButtonItem) {
        dobTextfield.resignFirstResponder()
    }
    
    @IBAction func maleSelected(_ sender: UIButton) {
        setGender(Gender.male)
    }

    @IBAction func femaleSelected(_ sender: UIButton) {
        setGender(Gender.female)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fillInDetails()

        dobTextfield.inputView = datePickerView

        genderView.layer.borderWidth = 0.5
        genderView.layer.borderColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
        genderView.layer.cornerRadius = 5
    }

    private

    func fillInDetails() {
        let user = User.currentUser!

        nameTextField.text = user.fullName
        emailTextField.text = user.email
        phoneTextField.text = user.phone
    }

    func setGender(_ gender: Gender) {
        let male_unchecked = UIImage(named: "Male")
        let female_unchecked = UIImage(named: "Female")

        let male_checked = UIImage(named: "Male_check")
        let female_checked = UIImage(named: "Female_check")

        switch gender {
        case .male:
            maleImage.setImage(male_checked, for: UIControlState())
            femaleImage.setImage(female_unchecked, for: UIControlState())
        case .female:
            maleImage.setImage(male_unchecked, for: UIControlState())
            femaleImage.setImage(female_checked, for: UIControlState())
        }
    }

}
