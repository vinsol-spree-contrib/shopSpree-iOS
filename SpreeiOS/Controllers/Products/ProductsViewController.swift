//
//  ProductsViewController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 28/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class ProductsViewController: BaseViewController {
    // Hardcoded - as the server does not return the total count of products currently.
    let totalPages = 4
    let productsPerPage = 10

    var isLoading = true
    var products = [Product]()

    var currentPageNo = 1
    var currentProductView = Product.View.List

    @IBOutlet weak var navBarView: AutoHideNavBarView!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavBar()

        fetchProducts(currentPageNo)

        setProductView(to: .List)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.tabBarController?.tabBar.isHidden = false

        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productDetail" {
            if let controller = segue.destination as? ProductDetailViewController {
                if let cell = sender as? UICollectionViewCell {
                    if let indexPath = collectionView.indexPath(for: cell) {
                        let product = products[indexPath.row]
                        controller.productID = product.id!
                    }
                }
            }
        }
    }

    private

    func configureNavBar() {
        let primaryNavBar = TitleNavBarView()
        let secondaryNavBar = ProductNavBarView()

        primaryNavBar.delegate = self
        primaryNavBar.setTitle("Products")

        secondaryNavBar.delegate = self
        secondaryNavBar.isHidden = true

        navBarView.primaryNavBar = primaryNavBar
        navBarView.secondaryNavBar = secondaryNavBar

        navBarView.configure()
    }
}

private extension ProductsViewController {

    func fetchProducts(_ pageNo: Int) {

        var data = URLRequestParams()
        data["page"] = currentPageNo as AnyObject?
        data["per_page"] = productsPerPage as AnyObject?

        ProductApiClient.products(data, success: { products in
            self.products += products
            self.isLoading = false
            self.navBarView.secondaryNavBar?.isHidden = false
            self.collectionView.reloadData()
        }, failure: { apiError in
            self.showApiErrorAlert(apiError)
        })
    }

}

extension ProductsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!

        performSegue(withIdentifier: "productDetail", sender: cell)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.bounds.origin.y
        let distanceFromBottom = scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.frame.size.height

        if position < 0 {
            navBarView.scrollToPrimaryNavBar()
        } else if distanceFromBottom < 0 {
            navBarView.scrollToSecondaryNavBar()
        } else {
            navBarView.scrollTo(position: position)
        }
    }

}

extension ProductsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: ProductCell

        switch currentProductView {
        case .List: cell = productListCell(indexPath); break
        case .Grid: cell = productGridCell(indexPath); break
        }

        fetchNextPageProducts(indexPath)
        
        return cell
    }

    private

    func productListCell(_ indexPath: IndexPath) -> ProductCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as! ProductCell
        let product = products[indexPath.row]

        cell.configure(forProduct: product)

        return cell
    }

    func productGridCell(_ indexPath: IndexPath) -> ProductCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductGridCell", for: indexPath) as! ProductCell
        let product = products[indexPath.row]

        cell.configure(forProduct: product)

        return cell
    }

    func fetchNextPageProducts(_ indexPath: IndexPath) {
        if indexPath.row == (currentPageNo * productsPerPage - 1) {
            if currentPageNo < totalPages {
                self.currentPageNo += 1

                DispatchQueue.main.async { [unowned self] in
                    self.fetchProducts(self.currentPageNo)
                }
            }
        }
    }
}

extension ProductsViewController: TitleNavBarViewDelegate {

    func didGoBack() {
        navigationController!.popViewController(animated: true)
    }

}

extension ProductsViewController: ProductNavBarViewDelegate {

    func didSortProducts() {
        print("TBD - Sorting products")
    }

    func didFilterProducts() {
        print("TBD - Filtering products")
    }

    func didChangeProductView(to productView: Product.View) {
        setProductView(to: productView)

        collectionView.reloadData()
    }

    func setProductView(to productView: Product.View) {
        currentProductView = productView

        switch productView {
        case .List:
            self.collectionView.reloadData()

            let productListFlowLayout = ProductListFlowLayout()
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout(productListFlowLayout, animated: false)

            break
        case .Grid:
            self.collectionView.reloadData()

            let productGridFlowLayout = ProductGridFlowLayout()
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout(productGridFlowLayout, animated: false)

            break
        }
    }
}
