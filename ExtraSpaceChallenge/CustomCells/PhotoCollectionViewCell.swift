//
//  PhotoCollectionViewCell.swift
//  ExtraSpaceChallenge
//
//  Created by orion on 8/6/21.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    func configure(with viewModel: PhotosViewModel, indexPath: IndexPath) {
        
        self.loadingIndicator.hidesWhenStopped = true
        self.loadingIndicator.startAnimating()
        
        guard let url = URL(string: viewModel.photoData![indexPath.row].thumbnailUrl) else { return }
        
        UIImage.getPhotoForURL(url: url) { [weak self] image in
            guard let image = image else { return }
            
            image.cache(with: url.absoluteString)
            
            self?.imageView.image = image
            self?.loadingIndicator.stopAnimating()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
    }
}
