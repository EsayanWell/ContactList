//
//  CustomTextField.swift
//  ContactList
//
//  Created by Владимир Есаян on 06.10.2023.
//

import UIKit

class CustomTextField: UITextField {

    // Отступ от границы слева до картинки
    let leftImagePadding: CGFloat = 12.0
    // Отступ от картинки до placeholder
    let placeholderLeftPadding: CGFloat = 8.0
    // Отступ от границы справа до картинки
    let rightImagePadding: CGFloat = 12.0
    // Отступ от картинки справа до placeholder
    let placeholderRightPadding: CGFloat = 91.0
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += leftImagePadding
        return rect
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        rect.origin.x += placeholderLeftPadding + placeholderLeftPadding
        rect.size.width -= (placeholderLeftPadding + placeholderLeftPadding + rightImagePadding + placeholderRightPadding)
        return rect
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= rightImagePadding
        return rect
    }
}

