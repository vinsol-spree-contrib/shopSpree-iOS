//
//  BrandOfferCell.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 03/09/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class BrandOfferCell: UITableViewCell {

    var imageURLs = [String]()

    var imageCount: Int {
        return imageURLs.count
    }

    var tilesPerColumn: Int {
        return 2
    }

    var tileWidth: Int {
        return Int(cellView.bounds.size.width - 36) / tilesPerColumn
    }

    var tileHeight: Int {
        return tileWidth
    }

    @IBOutlet weak var cellView: UIView!

    @IBOutlet weak var offerHeaderView: OfferHeaderView!

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var innerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        cellView.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)

        innerView.clipsToBounds = true
        innerView.layer.cornerRadius = 5

        offerHeaderView.label.textColor = UIColor.white
        offerHeaderView.button.backgroundColor = UIColor.white
        offerHeaderView.button.setTitleColor(UIColor.primary, for: .normal)
    }

    func configure(forBanner banner:Banner) {
        imageURLs = banner.imageURLs

        offerHeaderView.label.text = banner.displayName

        buildTiles()
    }

    func buildTiles() {
        for tileNo in 0..<imageCount {

            let url = imageURLs[tileNo]
            let tile = prepareTile(url)

            tile.tag = 100 + tileNo

            let x = xCoordForTile(tileNo)
            let y = yCoordForTile(tileNo)

            tile.frame = CGRect(x: x,
                                y: y,
                                width: tileWidth,
                                height: tileHeight)
            if x != 0 {
                tile.layer.addBorder(.left, color: UIColor.lightGray, thickness: 0.4)
            }

            if y != 0 {
                tile.layer.addBorder(.top, color: UIColor.lightGray, thickness: 0.4)
            }

            innerView.addSubview(tile)
        }
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
        return (tileNo % tilesPerColumn) * tileWidth
    }
    
    func yCoordForTile(_ tileNo: Int) -> Int {
        return (tileNo / tilesPerColumn) * tileHeight
    }
}
