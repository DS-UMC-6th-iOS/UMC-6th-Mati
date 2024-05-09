//
//  UIView+Extension.swift
//  CatStaGram
//
//  Created by 김미주 on 07/05/2024.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat { // 모따기
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
