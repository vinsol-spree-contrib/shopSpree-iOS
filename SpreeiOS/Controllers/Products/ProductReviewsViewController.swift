//
//  ProductReviewsViewController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 23/06/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class ProductReviewsViewController: BaseViewController {

    var product: Product!

    var reviews: [ProductReview] {
        return product.reviews
    }

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ProductReviewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
}

extension ProductReviewsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  (indexPath as NSIndexPath).row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCell", for: indexPath) as! RatingCell
            cell.configure(forProduct: product)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
            let review = reviews[(indexPath as NSIndexPath).row - 1]
            cell.configure(forProductReview: review)
            return cell
        }
    }
}
