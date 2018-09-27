//
//  PlayMovieTableViewCell.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import UIKit

class PlayMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(withViewModel viewModel: MovieDetails.GetMovie.ViewModel.DisplayedMovie) {
        showData(viewModel: viewModel)
    }
    
    private func showData(viewModel: MovieDetails.GetMovie.ViewModel.DisplayedMovie) {
        if CheckInternet.Connection() {
            playButton.isEnabled = true
            playButton.backgroundColor = .red
            self.isUserInteractionEnabled = true
        } else {
            playButton.isEnabled = false
            playButton.backgroundColor = .gray
            self.isUserInteractionEnabled = false
        }
    }
}
