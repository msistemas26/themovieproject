//
//  AVPlayerViewController + LandscapeOrientation.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/27/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import AVKit

extension AVPlayerViewController {
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }
}
