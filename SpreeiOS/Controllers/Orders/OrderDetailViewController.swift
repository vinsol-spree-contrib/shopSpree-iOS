//
//  OrderDetailViewController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 28/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class OrderDetailViewController: BaseViewController {

    var order: Order!

    @IBOutlet weak var idLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.idLabel.text = order.id
    }

}
