//
//  UIImage.swift

//
//  Created by sondang on 5/9/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

extension UIImage {
    
    func tinted(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        color.set()
        withRenderingMode(.alwaysTemplate)
            .draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    static func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    func imageMaskedWith(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        var image: UIImage?
        
        // begin drawing
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.scaleBy(x: 1, y: -1)
        context?.translateBy(x: 0, y: -rect.size.height)
        context?.clip(to: rect, mask: self.cgImage!)
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    func crop(x: CGFloat, y: CGFloat, size: CGSize) -> UIImage {
        let cropRect = CGRect(x: x, y: y, width: size.width, height: size.height)
        let imageCrop = cgImage!.cropping(to: cropRect)
        let image = UIImage(cgImage: imageCrop!, scale: 1, orientation: .up)
        
        return image
    }
    
    static func crop(image: UIImage, x: CGFloat, y: CGFloat, size: CGSize) -> UIImage {
        let cropRect = CGRect(x: x, y: y, width: size.width*image.scale, height: size.height*image.scale)
        let imageCrop = image.cgImage!.cropping(to: cropRect)
        let newImage = UIImage(cgImage: imageCrop!, scale: 1, orientation: .up)
        
        return newImage
    }
    
    func sprites(row: Int, column: Int) -> [UIImage] {
        let spriteWidth = self.size.width/CGFloat(column)
        let spriteHeight = self.size.height/CGFloat(row)
        var sprites = [UIImage]()
        for rowIndex in 0...row-1 {
            for columnIndex in 0...column-1 {
                let image = UIImage.crop(image: self, x: CGFloat(columnIndex)*spriteWidth*self.scale, y: CGFloat(rowIndex)*spriteHeight*self.scale, size: CGSize(width: spriteWidth, height: spriteHeight))
                sprites.append(image)
            }
        }
        
        return sprites
    }
    
}
