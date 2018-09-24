//
//  MovieDetailsTableViewHeader.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import UIKit

class MovieDetailsTableViewHeader: UITableViewCell {
    
    @IBOutlet weak var closeButtom: UIButton!
    
    @IBAction func didTapCloseButtom(_ sender: UIButton)
    {
        
    }
    
    func setup(withViewModel viewModel: MovieDetails.GetMovie.ViewModel.DisplayedMovie) {
        showData(viewModel: viewModel)
    }
    
    private func showData(viewModel: MovieDetails.GetMovie.ViewModel.DisplayedMovie) {
        //poster.loadImage(fromUrl: viewModel.poster_path)
    }
    
}
