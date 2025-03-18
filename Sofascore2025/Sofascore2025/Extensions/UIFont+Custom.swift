//
//  UIFont.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 16.03.2025..
//

import UIKit

extension UIFont {
    static var robotoBold14: UIFont {
        return UIFont(name: "Roboto-Bold", size: 14) ?? UIFont.boldSystemFont(ofSize: 14)
    }
    
    static var robotoRegular14: UIFont {
        return UIFont(name: "Roboto", size: 14) ?? UIFont.systemFont(ofSize: 14)
    }
}

