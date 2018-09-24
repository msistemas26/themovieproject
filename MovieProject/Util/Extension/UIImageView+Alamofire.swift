//
//  UIImageView+Alamofire.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {

    func loadImage(fromUrl url: String, size: CGSize)
    {
        let posterUrl = ImagePath.poster_path_original.rawValue + url
        Alamofire.request(posterUrl).responseImage { response in
            if let image = response.result.value {
                let imageFilter = AspectScaledToFillSizeFilter(size: size)
                self.image = imageFilter.filter(image)
            }
        }
    }
}
