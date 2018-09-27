//
//  UIView+Alamofire.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/24/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIView {
    
    func setBackgroundImage(fromUrl url: String)
    {
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.frame
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.addSubview(blurEffectView)
            self.sendSubview(toBack: blurEffectView)
        }
        
        let posterUrl = ImagePath.poster_path_original.rawValue + url
        let imageFilter = AspectScaledToFillSizeFilter(size: self.frame.size)
        
        guard let url = URL(string: posterUrl) else {
            return
        }
        
        let imageView = UIImageView()
        imageView.af_setImage(withURL: url, placeholderImage: nil, filter: imageFilter, progress: nil, imageTransition: .noTransition, runImageTransitionIfCached: false, completion: { (response) in
            let imageFilter = AspectScaledToFillSizeFilter(size: self.frame.size)
            self.backgroundColor = UIColor(patternImage:imageFilter.filter(response.result.value!))
        })
    }
}
