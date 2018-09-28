//
//  CategoryFilterPresenter.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/24/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import Foundation

protocol ListCategoriesPresentationLogic
{
    func presentFetchedCategories(response: ListCategories.FetchCategories.Response)
}

class ListCategoriesPresenter: ListCategoriesPresentationLogic
{
    
    weak var viewController: ListCategoriesDisplayLogic?
    
    func presentFetchedCategories(response: ListCategories.FetchCategories.Response)
    {
        var displayedCategories: [ListCategories.FetchCategories.ViewModel.DisplayedCategory] = []
        for category in response.categories
        {
            let displayedCategory = ListCategories.FetchCategories.ViewModel.DisplayedCategory(id: category.id, name: category.name, path: category.path)
            displayedCategories.append(displayedCategory)
        }
        let viewModel = ListCategories.FetchCategories.ViewModel(displayedCategories: displayedCategories)
        viewController?.displayFetchedCategories(viewModel: viewModel)
    }
}
