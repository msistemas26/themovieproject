//
//  MovieCollectionViewCell.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        poster.image = nil
    }
    
    func setup(withViewModel viewModel: ListMovies.FetchMovies.ViewModel.DisplayedMovie) {
        showData(viewModel: viewModel)
    }
    
    private func showData(viewModel: ListMovies.FetchMovies.ViewModel.DisplayedMovie) {
        let size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        poster.loadImage(fromUrl: viewModel.poster_path, size: size)
    }
}
