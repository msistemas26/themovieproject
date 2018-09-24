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
        let posterUrl = ImagePath.poster_path_original.rawValue + url
        Alamofire.request(posterUrl).responseImage { response in
            if let image = response.result.value {
                let imageFilter = AspectScaledToFillSizeFilter(size: self.frame.size)
                self.backgroundColor = UIColor(patternImage:imageFilter.filter(image))
            }
        }
    }
}
