//
//  UILabel+Ext.swift
//  Quick-Country-Info
//
//  Created by yilmaz on 27.05.2022.
//

import UIKit

extension UILabel {
    func labelSizeChange(into font: UIFont, from locationNumber: Int, to length: Int){
        let myMutableString = NSMutableAttributedString(string: self.text ?? "")
        myMutableString.addAttribute(NSAttributedString.Key.font,
                                     value: font,
                                     range: NSRange(location: locationNumber, length: length))
        self.attributedText = myMutableString
    }
}
