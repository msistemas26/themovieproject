//
//  CategoryFilterInteractor.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/24/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import Foundation

protocol ListCategoriesBusinessLogic
{
    func fetchCategories(request: ListCategories.FetchCategories.Request)
}

protocol ListCategoriesDataStore
{
    var categories: [Category]? { get }
}

final class ListCategoriesInteractor: ListCategoriesBusinessLogic, ListCategoriesDataStore
{
    var presenter: ListCategoriesPresentationLogic?
    var categoriesDataProvider: ServiceDataProvider
    
    var categories: [Category]?
    
    init() {
        self.categoriesDataProvider = ServiceDataProvider()
    }
    
    func fetchCategories(request: ListCategories.FetchCategories.Request)
    {
        categoriesDataProvider.fetchCategories() { (categories) in
            self.categories = categories
            let response = ListCategories.FetchCategories.Response(categories: categories)
            self.presenter?.presentFetchedCategories(response: response)
        }
    }
    
}
