//
//  CategoryOfferCell.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 30/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class CategoryOfferCell: UITableViewCell {

    var imageURLs = [String]()

    var imageCount: Int {
        return imageURLs.count
    }

    var tileWidth: Int {
        return Int(cellView.bounds.size.width / 2.25)
    }

    var tileHeight: Int {
        return tileWidth
    }

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var offerHeaderView: OfferHeaderView!
    @IBOutlet weak var scrollView: UIScrollView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(forBanner banner:Banner) {
        imageURLs = banner.imageURLs
        offerHeaderView.label.text = banner.displayName

        buildTiles()
    }

    func buildTiles() {
        let tileCount = imageCount

        for tileNo in 0..<imageCount {

            let url = imageURLs[tileNo]
            let tile = prepareTile(url)

            tile.tag = 100 + tileNo
            tile.frame = CGRect(x: xCoordForTile(tileNo),
                                y: yCoordForTile(tileNo),
                                width: tileWidth,
                                height: tileHeight)

            scrollView.addSubview(tile)
        }

        let width = CGFloat(tileCount * tileWidth)
        let height = CGFloat(tileHeight)

        scrollView.contentSize = CGSize(width: width, height: height)
    }

    private

    func prepareTile(_ imageURL: String) -> UIImageView {
        let image = UIImageView()

        if let url = URL(string: imageURL) {
            image.loadImageWithURL(url)
        }

        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGestureRecognizer())

        return image
    }

    func tapGestureRecognizer() -> UITapGestureRecognizer {
        let tableView = self.superview?.superview as! UITableView
        let controller = tableView.delegate as! HomeViewController

        let tapGestureRecognizer = UITapGestureRecognizer(target: controller, action: #selector(controller.navigateToProducts))
        tapGestureRecognizer.cancelsTouchesInView = false
        tapGestureRecognizer.delegate = self

        return tapGestureRecognizer
    }

    func xCoordForTile(_ tileNo: Int) -> Int {
        return tileNo * tileWidth
    }

    func yCoordForTile(_ tileNo: Int) -> Int {
        return 0
    }
}
