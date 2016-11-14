//
//  UIReadOnlyTextField.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 31/08/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class UIReadOnlyTextField: UITextField {

    override func caretRect(for position: UITextPosition!) -> CGRect {
        return CGRect.zero
    }

    override func selectionRects(for range: UITextRange) -> [Any] {
        return []
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        // Disable copy, select all, paste
        if action == #selector(UIResponderStandardEditActions.copy(_:)) || action == #selector(UIResponderStandardEditActions.selectAll(_:)) || action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        // Default
        return super.canPerformAction(action, withSender: sender)
    }

}
