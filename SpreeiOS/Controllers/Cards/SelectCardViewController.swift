//
//  SelectCardViewController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 12/11/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class SelectCardViewController: BaseViewController {

    var isLoading = true

    var selectedCard: Card?

    var cards = [Card]()

    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var tableView: UITableView!

    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchCards()
    }
}

private extension SelectCardViewController {

    func fetchCards() {
        CardApiClient.cards({ cards in
                self.cards = cards
                self.isLoading = false
                self.tableView.reloadData()
            }, failure: { apiError in
                self.showApiErrorAlert(apiError)
        })
    }

}

extension SelectCardViewController: UITableViewDataSource {

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
            let card = cards[indexPath.row]

            cell.tag = indexPath.row
            cell.configure(forCard: card)

            if let selectedCard = selectedCard, selectedCard.id! == card.id! {
                cell.accessoryType = .checkmark
            }

            return cell
        }
    }

}

extension SelectCardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isLoading {
            return tableView.bounds.size.height        } else {
            return 180
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = cards[indexPath.row]

        self.selectedCard = card
        
        performSegue(withIdentifier: "cardSelected", sender: self)
    }
}
