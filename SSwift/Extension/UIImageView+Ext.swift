//
//  UIImageView.swift

//
//  Created by sondang on 7/12/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(_ image: UIImage) {
        self.image = image
    }
    
    func setImage(_ image: UIImage, color: UIColor) {
        self.image = image.imageMaskedWith(color: color)
    }
    
    func setImage(withName name: String, color: UIColor) {
        self.image = UIImage(named: name)!.imageMaskedWith(color: color)
    }
    
    func animate(images: [UIImage], fps: Int) {
        animationImages = images
        let duration = Float(images.count)/Float(fps)
        animationDuration = TimeInterval(duration)
        startAnimating()
    }
    
}
