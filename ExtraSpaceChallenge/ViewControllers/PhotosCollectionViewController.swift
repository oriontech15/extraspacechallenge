//
//  ViewController.swift
//  ExtraSpaceChallenge
//
//  Created by orion on 8/6/21.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    private var photosViewModel: PhotosViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.photosViewModel = PhotosViewModel()
        
        // Bind the View Controller to the ViewModel to update its views when the ViewModel is updated
        self.photosViewModel.updateForBinded = {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
        
        // Request the first page of data
        self.photosViewModel.getNextPageOfPhotoData { [weak self] error in
            guard let error = error else { return }
            self?.showErrorAlert(error: error)
        }
    }
    
    deinit {
        self.photosViewModel.updateForBinded = nil
        self.photosViewModel = nil
    }
    
    private func showErrorAlert(error: Error) {
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(okayAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photosViewModel.photoData?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: photosViewModel, indexPath: indexPath)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Make sure that we are attempting to display the last cell in the collectionView.
        // This means that we are at the bottom and need to load the next page of photos
        if indexPath.row == photosViewModel.photoData!.count - 1 {            
            self.photosViewModel.getNextPageOfPhotoData { [weak self] error in
                guard let error = error else { return }
                self?.showErrorAlert(error: error)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Left padding = 20
        // Right padding = 20
        // minimum 10 points of space between cells
        // We want 4 cells across so that means there will be 3 spaces
        // 20 + 20 + (10 * 3) = 70
        
        let length = (self.view.bounds.width - 70) / 4
        return CGSize(width: length, height: length)
    }
}

