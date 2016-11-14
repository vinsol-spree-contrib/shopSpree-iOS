//
//  ProductDetailViewController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 28/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class ProductDetailViewController: BaseViewController {

    var productID = 36
    var product: Product?

    @IBOutlet weak var navBarView: StaticNavBarView!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!

    @IBOutlet weak var galleryView: ImageGallery!
    @IBOutlet weak var productDetailsView: ProductDetailsView!
    @IBOutlet weak var productPropertiesView: ProductPropertiesView!
    @IBOutlet weak var productActionsView: UIView!

    @IBOutlet weak var goToCartButton: UIButton!
    @IBOutlet weak var addToCartButton: UIButton!

    @IBAction func addToCart(_ sender: UIButton) {
        if !Order.hasCurrentOrder {
            OrderApiClient.createOrder({ order in
                Order.currentOrder = order
                self.addProductToCart()
            }, failure: { apiError in
                self.showApiErrorAlert(apiError)
            })
        } else {
            addProductToCart()
        }
    }

    @IBAction func goToCart(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 1
        self.navigationController?.popToRootViewController(animated: false)
    }

    @IBAction func buyNow(_ sender: UIButton) {
        print("TBD - Buy Now")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        customizeAppearance()

        configureNavBar()

        configureProductDetailsView()

        fetchProduct()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.tabBarController?.tabBar.isHidden = true

        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productReview" {
            if let controller = segue.destination as? ProductReviewsViewController {
                controller.product = product
            }
        }
    }

    func navigateToProductReviews(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "productReview", sender: sender)
    }

    private

    func configureNavBar() {
        let navBar = TitleNavBarView()

        navBar.delegate = self
        navBarView.navBar = navBar

        navBarView.configure()
    }

    func configureProductDetailsView() {
        productDetailsView.ratingView.delegate = self
    }

    func customizeAppearance() {
        goToCartButton.isHidden = true
        addToCartButton.isHidden = false

        productActionsView.layer.addBorder(.top, color: UIColor.darkGray, thickness: 0.7)
    }

    func requestData() -> URLRequestParams {
        var data = URLRequestParams()

        data["line_item[variant_id]"] = product!.variantId! as AnyObject?
        data["line_item[qty]"] = 1 as AnyObject?

        return data
    }

    func fillInProductDetails() {

        productDetailsView.configure(for: product!)

        if let imageURLs = product?.imageURLs {
            galleryView.delegate = self
            galleryView.imageURLs = imageURLs
            galleryView.setup()
        }

        if let properties = product?.properties {
            productPropertiesView.properties = properties
            productPropertiesView.setup()
        }

    }
}

private extension ProductDetailViewController {

    func fetchProduct() {
        ProductApiClient.product(productID, success: { product in
                self.product = product
                self.fillInProductDetails()
            }, failure: { apiError in
                self.showApiErrorAlert(apiError)
        })
    }

    func addProductToCart() {
        CartApiClient.addLineItem(Order.currentOrder!.id, data: requestData(), success: { order in
                Order.currentOrder = order

                let ac = UIAlertController.init(title: "Yoo Hoo!!!", message: "Item was successfully added to your cart!", preferredStyle: .alert)
                let okButton = UIAlertAction.init(title: "OK", style: .default, handler: nil)

                ac.addAction(okButton)
                self.present(ac, animated: true, completion: nil)

                self.goToCartButton.isHidden = false
                self.addToCartButton.isHidden = true

                self.refreshCartItemBadgeCount()
            }, failure: { apiError in
                self.showApiErrorAlert(apiError)
        })
    }
}

extension ProductDetailViewController: TitleNavBarViewDelegate {

    func didGoBack() {
        navigationController!.popViewController(animated: true)
    }

}

extension ProductDetailViewController: ImageGalleryDelegate {

    var imageWidth: CGFloat? {
        get {
            return galleryView.bounds.width
        }
    }

    var imageHeight: CGFloat? {
        get {
            return galleryView.bounds.height
        }
    }

}

extension ProductDetailViewController: ProductRatingViewDelegate {

    func didClickRatingButton() {
        print("TBD - Reviews / Ratings")
    }

}
