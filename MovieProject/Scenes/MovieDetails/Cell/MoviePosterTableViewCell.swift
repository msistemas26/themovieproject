//
//  MoviePosterTableViewCell.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviePosterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        poster.image = nil
    }

    func setup(withViewModel viewModel: MovieDetails.GetMovie.ViewModel.DisplayedMovie) {
        showData(viewModel: viewModel)
    }
    
    private func showData(viewModel: MovieDetails.GetMovie.ViewModel.DisplayedMovie) {
        
        let placeholderImage = UIImage(named: "defaultMovie")!
        let posterUrl = ImagePath.poster_path_original.rawValue + viewModel.poster_path
        
        guard let url = URL(string: posterUrl) else {
            poster.image = placeholderImage
            return
        }
        
        let imageFilter = AspectScaledToFillSizeFilter(size: poster.frame.size)
        
        poster.af_setImage(withURL: url, placeholderImage: placeholderImage, filter: imageFilter, progress: nil, imageTransition: .noTransition, runImageTransitionIfCached: false, completion: { (image) in
        })
    }
}
