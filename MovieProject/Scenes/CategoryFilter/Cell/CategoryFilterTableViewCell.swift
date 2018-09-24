//
//  CategoryFilterTableViewCell.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/24/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import UIKit

class CategoryFilterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var category: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(withViewModel viewModel: ListCategories.FetchCategories.ViewModel.DisplayedCategory) {
        showData(viewModel: viewModel)
    }
    
    private func showData(viewModel: ListCategories.FetchCategories.ViewModel.DisplayedCategory) {
        category.text = viewModel.name
    }
}
