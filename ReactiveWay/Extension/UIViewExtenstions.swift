//
//  uiViewExtenstions.swift
//  jaldilive
//
//  Created by Admin on 11/08/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

enum LinePosition {
    case linePositionTop
    case linePositionBottom
}
extension UIView {
    
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func setRoundCorner(BorderColor color: UIColor, CornerRadius radius: CGFloat, andBorderWidth borderWidth: CGFloat) {
        layer.borderWidth = borderWidth
        layer.borderColor = color.cgColor
        layer.cornerRadius = radius
        layer.masksToBounds = true
        self.clipsToBounds = true
    }
    func dropShadow(yourView:UIView) {
        yourView.layer.masksToBounds = false
        yourView.backgroundColor = UIColor.lightGray
        yourView.layer.shadowColor = UIColor.lightGray.cgColor
        yourView.layer.shadowOpacity = 1
        yourView.layer.shadowOffset = CGSize.zero
        yourView.layer.shadowRadius = 2
        yourView.layer.shouldRasterize = true
        yourView.layer.rasterizationScale = UIScreen.main.scale
      }
    func dropShadowAtBottom(color: UIColor, opacity: Float = 1, radius: CGFloat = 5, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 0.0
        layer.shouldRasterize = true
        //   layer.cornerRadius = 5.0
        layer.masksToBounds = false
    }
    func addLineToView(view: UIView, position: LinePosition, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        view.addSubview(lineView)
        let metrics = ["width": NSNumber(value: width)]
        let views = ["lineView": lineView]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: views))
        switch position {
        case .linePositionTop:
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views:views))
            break
        case .linePositionBottom:
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: views))
            break
        }
    }
    
    func animShow() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animHide(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()

        },  completion: {(_ completed: Bool) -> Void in
        self.isHidden = true
            })
    }
    
    func setGradientColor(with1stColor col1: UIColor, and2ndColor col2: UIColor) {
        let gl = CAGradientLayer()
        gl.colors = [col1.cgColor, col2.cgColor]
        gl.locations = [0.0, 1.0]
        gl.frame = self.bounds
        self.layer.insertSublayer(gl, at:0)
    }
    
    func drawDottedLineBorder(borderColor:UIColor,yourView:UIView) {
        let yourViewBorder = CAShapeLayer()
        yourViewBorder.strokeColor = borderColor.cgColor
        yourViewBorder.lineDashPattern = [2, 2]
        yourViewBorder.frame = yourView.bounds
        yourViewBorder.fillColor = nil
        yourViewBorder.path = UIBezierPath(rect: yourView.bounds).cgPath
        yourView.layer.addSublayer(yourViewBorder)
    }
    
}
extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
