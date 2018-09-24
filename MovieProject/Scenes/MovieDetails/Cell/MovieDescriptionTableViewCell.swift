//
//  MovieDescriptionTableViewCell.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import UIKit

class MovieDescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var overview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(withViewModel viewModel: MovieDetails.GetMovie.ViewModel.DisplayedMovie) {
        showData(viewModel: viewModel)
    }
    
    private func showData(viewModel: MovieDetails.GetMovie.ViewModel.DisplayedMovie) {
        overview.text = viewModel.overview
    }
}
