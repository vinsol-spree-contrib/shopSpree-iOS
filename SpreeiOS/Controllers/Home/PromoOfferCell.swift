//
//  PromoOfferCell.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 30/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class PromoOfferCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!

    var imageURLs = [String]()

    var imageCount: Int {
        return imageURLs.count
    }

    var previewPadding = 10
    var horizontalPadding = 10

    var widthPadding: Int {
        return previewPadding  + horizontalPadding
    }

    var heightPadding = 10

    var tileHeight: Int {
        return Int(cellView.bounds.height) - 2 * heightPadding
    }

    var tileWidth: Int {
        return Int(cellView.bounds.width) - 2 * widthPadding
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = UIColor.clear
        cellView.backgroundColor =  UIColor.clear

        scrollView.delegate = self
        scrollView.clipsToBounds = false
    }

    func configure(forBanner banner:Banner) {
        self.imageURLs = banner.imageURLs

        buildTiles()

        moveToTile(2)
    }

    func prepareTilesData() -> [String] {
        var tiles = [String]()

        tiles.append(imageURLs[imageCount - 2])
        tiles.append(imageURLs[imageCount - 1])

        for tile in imageURLs {
            tiles.append(tile)
        }

        tiles.append(imageURLs[0])
        tiles.append(imageURLs[1])

        return tiles
    }

    func buildTiles() {
        let tiles = prepareTilesData()
        let tileCount = tiles.count

        for tileNo in 0..<tileCount {

            let url = tiles[tileNo]
            let tile = prepareTile(url)

            tile.tag = 100 + tileNo
            tile.frame = CGRect(x: xCoordForTile(tileNo),
                                y: yCoordForTile(tileNo),
                                width: tileWidth,
                                height: tileHeight)

            scrollView.addSubview(tile)
        }

        scrollView.contentSize = CGSize(width: CGFloat(tileCount * tileWidth),
                                        height: cellView.bounds.size.height)
    }

    private

    func prepareTile(_ imageURL: String) -> UIImageView {
        let image = UIImageView()

        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.layer.shadowOpacity = 1
        image.layer.shadowOffset = CGSize(width: 5, height: 5);
        image.layer.shadowColor = UIColor.black.cgColor

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
        let origin = 0 + previewPadding / 2
        let x = origin + (horizontalPadding + tileWidth) * tileNo

        return x
    }

    func yCoordForTile(_ tileNo: Int) -> Int {
        return heightPadding
    }

    func moveToTile(_ tileNo: Int) {
        let x = (horizontalPadding + tileWidth) * tileNo
        let point = CGPoint(x: x, y: 0)

        scrollView.setContentOffset(point, animated: false)
    }
}

extension PromoOfferCell: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.size.width
        let currentPage = Int((scrollView.contentOffset.x + width / 2) / width)

        if currentPage == 1 {
            moveToTile(imageCount + 1)
        } else if currentPage == (imageCount + 2) {
            moveToTile(2)
        }
    }

}
