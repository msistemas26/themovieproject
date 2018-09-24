//
//  MovieDetailsRouter.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import UIKit

protocol MovieDetailsRoutingLogic
{
    func routeToPlayMovie(segue: UIStoryboardSegue?)
    func routeBack()
}

protocol MovieDetailsDataPassing
{
    var dataStore: MovieDetailsDataStore? { get }
}

class MovieDetailsRouter: NSObject, MovieDetailsRoutingLogic, MovieDetailsDataPassing
{
    
    weak var viewController: MovieDetailsViewController?
    var dataStore: MovieDetailsDataStore?
    
    // MARK: Routing
    
    func routeBack() {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    func routeToPlayMovie(segue: UIStoryboardSegue?)
    {
        //Demo
    }
    
}
