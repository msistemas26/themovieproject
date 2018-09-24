//
//  MovieBasicInfoTableViewCell.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//


import UIKit

class MovieBasicInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var release_date: UILabel!
    @IBOutlet weak var vote_average: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(withViewModel viewModel: MovieDetails.GetMovie.ViewModel.DisplayedMovie) {
        showData(viewModel: viewModel)
    }
    
    private func showData(viewModel: MovieDetails.GetMovie.ViewModel.DisplayedMovie) {
        title.text = viewModel.title
        release_date.text = viewModel.release_date
        vote_average.text = String(viewModel.vote_average)
    }
}
