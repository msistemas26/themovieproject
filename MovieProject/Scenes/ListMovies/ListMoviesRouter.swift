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
    func routeToCategories()
}

protocol ListMoviesDataPassing
{
    var dataStore: ListMoviesDataStore? { get }
}

class ListMoviesRouter: NSObject, ListMoviesRoutingLogic, ListMoviesDataPassing
{
    weak var viewController: ListMoviesViewController?
   
    var dataStore: ListMoviesDataStore?
    
    func routeToMovieDetails(segue: UIStoryboardSegue?)
    {
         //USING SEGUE
        if let segue = segue {
            let destinationVC = segue.destination as! MovieDetailsViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToMovieDetails(source: dataStore!, destination: &destinationDS)
        }
    }
    
    func routeToCategories()
    {
        //USING PROGRAMATICALLY PRESENTATION
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationVController = storyboard.instantiateViewController(withIdentifier: "CategoryFilterViewController") as? CategoryFilterViewController, let controller = self.viewController else {
            return
        }
        destinationVController.transitioningDelegate = destinationVController
        controller.modalPresentationStyle = .custom
        controller.present(destinationVController, animated: true)
    }
    
    // MARK: Passing data
    
    func passDataToMovieDetails(source: ListMoviesDataStore, destination: inout MovieDetailsDataStore)
    {
        let selectedItem = viewController?.collectionView?.indexPathsForSelectedItems?.first?.item
        destination.movie = source.movies?[selectedItem!]
    }
}
