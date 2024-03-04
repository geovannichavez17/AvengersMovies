//
//  UIColor+Extensions.swift
//  AvengersMovies
//
//  Created by Geovanni Josue Chavez on 28/2/24.
//

import UIKit

extension UIColor {
    
    static let transparentBlack = UIColor(named: "transparentBlack")!
    
    @nonobjc class var dark: UIColor {
      return UIColor(red: 26.0 / 255.0, green: 40.0 / 255.0, blue: 46.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var infoAreaBlack: UIColor {
        return UIColor(red: 39.0 / 255.0, green: 37.0 / 255.0, blue: 47.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var semiTransparentBlack: UIColor {
        return UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.6)
    }
    
    @nonobjc class var transparent: UIColor {
        return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.0)
    }
    
    @nonobjc class var ghostWhite: UIColor {
        return UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    @nonobjc class var gold: UIColor {
        return UIColor(red: 255.0/255.0, green: 215.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }

}
