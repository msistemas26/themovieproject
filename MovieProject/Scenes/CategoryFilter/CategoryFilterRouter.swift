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
}
