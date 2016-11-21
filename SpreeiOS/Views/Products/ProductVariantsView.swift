//
//  ProductVariantsView.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 21/11/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//
import UIKit

protocol ProductVariantsViewDelegate {
    func didSelectVariant(variant: Variant)
}

class ProductVariantsView: UIView {

    var product: Product!

    var delegate: ProductVariantsViewDelegate?

    @IBOutlet weak var selectVariantButton: UIButton!
    @IBOutlet weak var selectVariantTextField: UITextField!

    @IBOutlet weak var variantSelectorView: UIView!
    @IBOutlet weak var variantPickerView: UIPickerView!
    @IBOutlet weak var donePickingButton: UIButton!
    @IBOutlet weak var cancelPickingButton: UIButton!


    @IBAction func startPickingVariant(_ sender: UIButton) {
        selectVariantTextField.becomeFirstResponder()
    }

    @IBAction func donePickingVariant(_ sender: UIButton) {
        selectVariantTextField.resignFirstResponder()

        let row = variantPickerView.selectedRow(inComponent: 0)
        let variant = product.variants[row]

        selectVariantButton.setTitle(variant.optionsText, for: .normal)

        delegate?.didSelectVariant(variant: variant)
    }

    @IBAction func cancelPickingVariant(_ sender: UIButton) {
        selectVariantTextField.resignFirstResponder()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        variantPickerView.delegate = self
        variantPickerView.dataSource = self

        selectVariantTextField.inputView = variantSelectorView

        variantSelectorView.autoresizingMask = .flexibleHeight
    }

}

extension ProductVariantsView: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return product!.variants.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return product!.variants[row].optionsText
    }

}
