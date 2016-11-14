//
//  SelectAddressViewController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 11/11/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class SelectAddressViewController: BaseViewController {

    var isLoading = true

    var selectedAddress: Address?

    var addresses = [Address]()

    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var tableView: UITableView!

    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchAddresses()
    }
}

private extension SelectAddressViewController {

    func fetchAddresses() {
        AddressApiClient.addresses({ addresses in
                self.addresses = addresses
                self.isLoading = false
                self.tableView.reloadData()
            }, failure: { apiError in
                self.showApiErrorAlert(apiError)
        })
    }

}

extension SelectAddressViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading {
            return 1
        } else {
            return addresses.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            return TableViewLoadingCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressCell
            let address = addresses[indexPath.row]

            cell.tag = indexPath.row
            cell.configure(forAddress: address)

            if selectedAddress!.id! == address.id! {
                cell.accessoryType = .checkmark
            }

            return cell
        }
    }

}

extension SelectAddressViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isLoading {
            return tableView.bounds.size.height        } else {
            return 150
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let address = addresses[indexPath.row]

        self.selectedAddress = address

        performSegue(withIdentifier: "addressSelected", sender: self)
    }
}
