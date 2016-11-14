//
//  UIImageView+DownloadImage.swift
//  StoreSearch
//
//  Created by Bharat Gupta on 30/04/16.
//  Copyright © 2016 Bharat Gupta. All rights reserved.
//

import UIKit

extension UIImageView {

    func loadImageWithURL(_ url: URL) -> URLSessionDownloadTask {
        let session = URLSession.shared

        let downloadTask = session.downloadTask(with: url, completionHandler: { [weak self] url, response, error in
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    if let strongSelf = self {
                        let width = strongSelf.bounds.width
                        let height = strongSelf.bounds.height

                        let resizedImage = resizeImage(image, newWidth: width, newHeight: height)

                        strongSelf.image = resizedImage
                    }
                }
            }
        })

        downloadTask.resume()

        return downloadTask
    }
}


func resizeImage(_ image: UIImage, newWidth: CGFloat, newHeight: CGFloat) -> UIImage {
    let size = CGSize(width: newWidth, height: newHeight)

    UIGraphicsBeginImageContext(size)

    let rect = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
    image.draw(in: rect)

    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
}
