//
//  AccountsController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 25/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class AccountsController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if User.isLoggedIn {
            switch section {
            case 1: return 4
            case 2: return 3
            case 3: return 1
            default: return 0
            }
        } else {
            switch section {
            case 0: return 1
            case 2: return 3
            default: return 0
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).section == 2 {
            switch (indexPath as NSIndexPath).row {
            case 0: openURL("http://www.vinsol.com"); break
            case 1: openURL("http://www.vinsol.com"); break
            case 2: openURL("http://www.vinsol.com/contact"); break
            default: break
            }
        } else if (indexPath as NSIndexPath).section == 3 {
            logoutCurrentUser()
        }
    }


    private

    func openURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.openURL(url)
        }
    }

    func logoutCurrentUser() {
        let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { _ in
            User.currentUser = nil
            self.tableView.reloadData()
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(ok)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)
    }

}
