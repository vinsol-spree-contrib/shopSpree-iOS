//
//  AddressesViewController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 26/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

protocol AddressesViewDelegate {
    func addressesView(_ controller: BaseViewController, didFinishAddingAddress address: Address)
    func addressesView(_ controller: BaseViewController, didFinishUpdatingAddress address: Address)
}

class AddressesViewController: BaseViewController {

    var isLoading = true

    var addresses = [Address]()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchAddresses()
    }

    @IBAction func performAction(_ sender: UIButton) {
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let edit = UIAlertAction(title: "Edit", style: .default, handler: { action in
            self.performSegue(withIdentifier: "editAddress", sender: sender)
        })

        let delete = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            let indexPath = IndexPath(row: sender.tag, section: 0)

            self.deleteAddress(atIndexPath: indexPath)
        })

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        ac.addAction(edit)
        ac.addAction(delete)
        ac.addAction(cancel)

        present(ac, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? AddressFormViewController {
            controller.delegate = self

            if segue.identifier == "editAddress" {
                if let editButton = sender as? UIButton {
                    let row = editButton.tag
                    controller.address = addresses[row]
                    controller.title = "Edit Address"
                }
            }
        }
    }

    
}

private extension AddressesViewController {

    func fetchAddresses() {
        AddressApiClient.addresses({ addresses in
            self.addresses = addresses
            self.isLoading = false
            self.tableView.reloadData()
        }, failure: { apiError in
            self.showApiErrorAlert(apiError)
        })
    }

    func deleteAddress(atIndexPath indexPath: IndexPath) {
        let id = addresses[(indexPath as NSIndexPath).row].id!

        AddressApiClient.removeAddress(id, success: { _ in
            self.addresses.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }, failure: { apiError in
            self.showApiErrorAlert(apiError)
        })
    }
}

extension AddressesViewController: UITableViewDataSource {

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
            let address = addresses[(indexPath as NSIndexPath).row]

            cell.configure(forAddress: address)

            cell.tag = indexPath.row

            return cell
        }
    }

}

extension AddressesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isLoading {
            return tableView.bounds.size.height - navigationController!.navigationBar.bounds.size.height
        } else {
            return 150
        }
    }
}

extension AddressesViewController: AddressesViewDelegate {
    func addressesView(_ controller: BaseViewController, didFinishAddingAddress address: Address) {
        let indexPath = IndexPath(row: addresses.count, section: 0)
        addresses.append(address)
        tableView.insertRows(at: [indexPath], with: .fade)
    }

    func addressesView(_ controller: BaseViewController, didFinishUpdatingAddress address: Address) {
        if let row = addresses.index(where: { $0 == address }) {
            addresses[row] = address
            let indexPath = IndexPath(row: row, section: 0)
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
}
