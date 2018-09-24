//
//  ListMoviesRouter.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import UIKit

@objc protocol ListMoviesRoutingLogic
{
    func routeToMovieDetails(segue: UIStoryboardSegue?)
    func routeToCategories(segue: UIStoryboardSegue?)
}

protocol ListMoviesDataPassing
{
    var dataStore: ListMoviesDataStore? { get }
}

class ListMoviesRouter: NSObject, ListMoviesRoutingLogic, ListMoviesDataPassing
{
    
    weak var viewController: ListMoviesViewController?
    var dataStore: ListMoviesDataStore?
    
    // MARK: Routing
    
    func routeToMovieDetails(segue: UIStoryboardSegue?)
    {
        if let segue = segue {
            let destinationVC = segue.destination as! MovieDetailsViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToMovieDetails(source: dataStore!, destination: &destinationDS)
        }
    }
    
    func routeToCategories(segue: UIStoryboardSegue?)
    {
        if let segue = segue {
            let destinationVC = segue.destination as! CategoryFilterViewController
            destinationVC.transitioningDelegate = destinationVC
            destinationVC.modalPresentationStyle = .custom
            
            //var destinationDS = destinationVC.router!.dataStore!
            //passDataToMovieDetails(source: dataStore!, destination: &destinationDS)
        }
    }
    
    // MARK: Passing data
    
    func passDataToMovieDetails(source: ListMoviesDataStore, destination: inout MovieDetailsDataStore)
    {
        let selectedItem = viewController?.collectionView?.indexPathsForSelectedItems?.first?.item
        destination.movie = source.movies?[selectedItem!]
    }
    
    
    
}
