//
//  CategoryFilterRouter.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/24/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import UIKit

protocol ListCategoriesRoutingLogic
{
    func routeBack()
    func routeBack(withCategory category:ListCategories.FetchCategories.ViewModel.DisplayedCategory)
}

protocol ListCategoriesDataPassing
{
    var dataStore: ListCategoriesDataStore? { get }
}

class ListCategoriesRouter: NSObject, ListCategoriesRoutingLogic, ListCategoriesDataPassing
{
    
    weak var viewController: CategoryFilterViewController?
    var dataStore: ListCategoriesDataStore?
    
    // MARK: Routing
 
    func routeBack() {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    func routeBack(withCategory category:ListCategories.FetchCategories.ViewModel.DisplayedCategory)
    {
        guard let controller = self.viewController else {
            return
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func passDataToParent(category: ListCategories.FetchCategories.ViewModel.DisplayedCategory, destination: inout ListMoviesDataStore)
    {
        // Pass data backward
    }
    
    func navigateToParent(source: CategoryFilterViewController, destination: ListMoviesViewController)
    {
        // Navigate backward (dismissing)
        source.dismiss(animated: true, completion: nil)
    }
}
