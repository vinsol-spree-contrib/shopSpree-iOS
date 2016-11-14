//
//  CardsViewController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 25/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class CardsViewController: BaseViewController {

    var isLoading = true

    var cards = [Card]()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchCards()
    }

}

private extension CardsViewController {

    func fetchCards(){
        CardApiClient.cards({ cards in
            self.cards = cards
            self.isLoading = false
            self.tableView.reloadData()
        }, failure: { apiError in
            self.showApiErrorAlert(apiError)
        })
    }

    func deleteCard(atIndexPath indexPath: IndexPath) {
        let id = cards[(indexPath as NSIndexPath).row].id!

        CardApiClient.removeCard(id, success: { _ in
                self.cards.remove(at: indexPath.row)
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }, failure: { apiError in
                self.showApiErrorAlert(apiError)
        })
    }
}

extension CardsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading {
            return 1
        } else {
            return cards.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            return TableViewLoadingCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Card", for: indexPath) as! CardCell
            let card = cards[(indexPath as NSIndexPath).row]

            cell.configure(forCard: card)
            
            return cell
        }
    }

}

extension CardsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets.zero
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isLoading {
            return tableView.bounds.size.height - navigationController!.navigationBar.bounds.size.height
        } else {
            return 180
        }
    }
}
