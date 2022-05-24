//
//  asdas.swift
//  CountryApp
//
//  Created by yilmaz on 20.05.2022.
//

import UIKit

extension UIImage{
    func resizeImageWithHeight(newW: CGFloat, newH: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: newW, height: newH))
        self.draw(in: CGRect(x: 0, y: 0, width: newW, height: newH))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
