//
//  extensions.swift
//  Tip Calculator
//
//  Created by Gregory Jones on 8/8/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class salmonButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderWidth = 5
        self.layer.borderColor = Colors.darkPurple.cgColor
        self.backgroundColor = Colors.darkPurple
        self.layer.masksToBounds = false
        //self.layer.shadowColor = Colors.darkGreyColor.cgColor
       // self.layer.shadowOpacity = 0.5
       // self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.cornerRadius = 4
        self.setTitleColor(.white, for: .normal)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class userInputField: UITextField  {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .right
        self.borderStyle = .none
        self.textColor = UIColor.white
        self.tintColor = UIColor.white
        
        self.font = UIFont(name: Fonts.montserratSemiBold, size: 28)
        self.borderStyle = .none
       // self.keyboardType = UIKeyboardType.numberPad
        self.autocapitalizationType = UITextAutocapitalizationType.none
        self.autocorrectionType = .no
        self.returnKeyType = UIReturnKeyType.done
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class billInputField: UITextField  {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .center
        self.borderStyle = .none
        self.textColor = UIColor.white
        self.tintColor = UIColor.white
        self.font = UIFont(name: Fonts.montserratSemiBold, size: 35)
        self.borderStyle = .none
        self.keyboardType = UIKeyboardType.numberPad
        self.autocapitalizationType = UITextAutocapitalizationType.none
        self.autocorrectionType = .no
        self.returnKeyType = UIReturnKeyType.done
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, bottom:NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
            
        }
        
        if let bottom = bottom {
            
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
            
        }
        
        
        if let leading = leading {
            
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
            
        }
        
        if let trailing = trailing  {
            
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
            
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    
    
}

extension String {
    
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
}
