//
//  UIImageExtension.swift
//  jaldilive
//
//  Created by Admin on 10/12/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
  func crop(to:CGSize) -> UIImage {
    guard let cgimage = self.cgImage else { return self }

    let contextImage: UIImage = UIImage(cgImage: cgimage)

    let contextSize: CGSize = contextImage.size

    //Set to square
    var posX: CGFloat = 0.0
    var posY: CGFloat = 0.0
    let cropAspect: CGFloat = to.width / to.height

    var cropWidth: CGFloat = to.width
    var cropHeight: CGFloat = to.height

    if to.width > to.height { //Landscape
        cropWidth = contextSize.width
        cropHeight = contextSize.width / cropAspect
        posY = (contextSize.height - cropHeight) / 2
    } else if to.width < to.height { //Portrait
        cropHeight = contextSize.height
        cropWidth = contextSize.height * cropAspect
        posX = (contextSize.width - cropWidth) / 2
    } else { //Square
        if contextSize.width >= contextSize.height { //Square on landscape (or square)
            cropHeight = contextSize.height
            cropWidth = contextSize.height * cropAspect
            posX = (contextSize.width - cropWidth) / 2
        }else{ //Square on portrait
            cropWidth = contextSize.width
            cropHeight = contextSize.width / cropAspect
            posY = (contextSize.height - cropHeight) / 2
        }
    }

    let rect: CGRect = CGRect(x : posX, y : posY, width : cropWidth, height : cropHeight)

    // Create bitmap image from context using the rect
    let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!

    // Create a new image based on the imageRef and rotate back to the original orientation
    let cropped: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)

    cropped.draw(in: CGRect(x : 0, y : 0, width : to.width, height : to.height))

    return cropped
  }
    
    func cropImage(image: UIImage, toRect: CGRect) -> UIImage? {
        // Cropping is available trhough CGGraphics
        let cgImage :CGImage! = image.cgImage
        let croppedCGImage: CGImage! = cgImage.cropping(to: toRect)

        return UIImage(cgImage: croppedCGImage)
    }
    
    
    
    
}
extension UIImageView {
  func setRounded() {
     let radius = self.frame.width / 2
      self.layer.cornerRadius = radius
      self.layer.masksToBounds = true
   }
    
//   open override var intrinsicContentSize: CGSize {
//    
//    let frameSizeWidth = self.frame.size.width
//
//            // image
//            // ⓘ In testing on iOS 12.1.4 heights of 1.0 and 0.5 were respected, but 0.1 and 0.0 led intrinsicContentSize to be ignored.
//            guard let image = self.image else
//            {
//                return CGSize(width: frameSizeWidth, height: 1.0)
//            }
//
//            // MAIN
//            let returnHeight = ceil(image.size.height * (frameSizeWidth / image.size.width))
//            return CGSize(width: frameSizeWidth, height: self.frame.size.height)
//    
////        if let myImage = self.image {
////            let myImageWidth = myImage.size.width
////            let myImageHeight = myImage.size.height
////            let myViewWidth = self.frame.size.width
////
////            let ratio = myViewWidth/myImageWidth
////            let scaledHeight = myImageHeight * ratio
////
////            return CGSize(width: myViewWidth, height: scaledHeight)
////        }
////
////        return CGSize(width: -1.0, height: -1.0)
//    }
}
