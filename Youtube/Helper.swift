//
//  Helper.swift
//  Youtube
//
//  Created by Macbook Pro on 8/1/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func rgp(_ red: CGFloat , _ green : CGFloat, _ blue : CGFloat)-> UIColor {
        
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

 

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}


class BaseCell : UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        
    }
    
}
