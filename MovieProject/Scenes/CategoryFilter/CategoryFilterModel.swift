//
//  CategoryFilterModel.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/24/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import Foundation

enum ListCategories
{
    // MARK: Use cases
    
    enum FetchCategories
    {
        struct Request
        {
        }
        struct Response
        {
            var categories: [Category]
        }
        struct ViewModel
        {
            struct DisplayedCategory
            {
                let id: Int
                let name :String
            }
            var displayedCategories: [DisplayedCategory]
        }
    }
}
