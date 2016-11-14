//
//  ImageGallery.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 24/10/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

protocol ImageGalleryDelegate {
    var imageWidth: CGFloat? { get }
    var imageHeight: CGFloat? { get }
}

class ImageGallery: UIView {

    var imageWidth: CGFloat {
        return delegate?.imageWidth ?? 25.0
    }

    var imageHeight: CGFloat {
        return delegate?.imageHeight ?? 25.0
    }

    var imageURLs = [String]()

    var slidesCount: Int {
        return imageURLs.count
    }

    let scrollView = UIScrollView()
    let pageControl = UIPageControl()

    var delegate: ImageGalleryDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        addScrollView()
        addPageControl()
    }

    func setup() {
        for slideNumber in 0..<slidesCount {
            let slide = sliderImageView(for: slideNumber)

            scrollView.addSubview(slide)
        }

        let totalWidth = CGFloat(slidesCount) * imageWidth
        let totalHeight = scrollView.bounds.size.height

        if slidesCount == 1 {
            pageControl.isHidden = true
        } else {
            pageControl.numberOfPages = slidesCount
        }

        scrollView.contentSize = CGSize(width: totalWidth, height: totalHeight)
    }

    private

    func addScrollView() {
        scrollView.delegate = self
        scrollView.isPagingEnabled = true;
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

        addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: -8).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: 8).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: -8).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: 8).isActive = true
    }

    func addPageControl() {
        addSubview(pageControl)

        pageControl.translatesAutoresizingMaskIntoConstraints = false

        pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -20).isActive = true
    }

    func sliderImageView(for slideNumber: Int) -> UIImageView {
        let image = UIImageView()

        image.tag = 100 + slideNumber

        if let url = URL(string: imageURLs[slideNumber]) {
            image.loadImageWithURL(url)
        }

        let x = xCoord(for: slideNumber)
        let y = yCoord(for: slideNumber)

        image.frame = CGRect(x: x, y: y, width: imageWidth, height: imageHeight)

        return image
    }

    func xCoord(for slideNumber: Int) -> CGFloat {
        return CGFloat(slideNumber) * imageWidth
    }

    func yCoord(for slideNumber: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

}

extension ImageGallery: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.size.width
        let currentPage = Int((scrollView.contentOffset.x + width / 2) / width)

        pageControl.currentPage = currentPage
    }
}
