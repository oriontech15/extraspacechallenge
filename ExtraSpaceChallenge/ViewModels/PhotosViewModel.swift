//
//  PhotosViewModel.swift
//  ExtraSpaceChallenge
//
//  Created by orion on 8/6/21.
//

import UIKit

class PhotosViewModel: NSObject {
    
    private let basePhotosURLString = "http://jsonplaceholder.typicode.com/photos"
    
    // MARK: Pagination Variables
    private(set) var currentPage = 0
    private(set) var nextPage = 1
    var pageSize = 20
    
    private var apiService: APIService!
    
    private(set) var photoData: [Photo]? {
        didSet {
            // Upon update of the photoData array the ViewModel notifies its bound ViewController about its changes.
            self.updateForBinded?()
        }
    }
    
    // Bind a listener to the viewModel to update view when viewModels data is updated
    var updateForBinded: (() -> ())?
    
    override init() {
        super.init()
        
        self.apiService = APIService()
    }
    
    func refreshData() {
        self.currentPage = 0
        self.nextPage = 1
    }
    
    /// Gets the next page of photo data based upon the current page,
    /// the total number of fetched pages and the pageSize. (Pagination)
    ///
    /// Upon retreival of the data, the data is decoded using JSONDecoder
    /// and the photoData array is updated to include the new decoded photo information
    func getNextPageOfPhotoData(completion: @escaping (Error?) -> Void) {
        
        guard currentPage < nextPage else { return }
        
        guard var urlComp = URLComponents(string: self.basePhotosURLString) else { return }
        
        let startParam = URLQueryItem(name: "_start", value: "\(currentPage)")
        let limitParam = URLQueryItem(name: "_limit", value: "\(pageSize)")
        
        urlComp.queryItems = [startParam, limitParam]
        
        var request = URLRequest(url: urlComp.url!)
        request.httpMethod = "GET"
        
        self.apiService.fetchDataFor(urlRequest: request) { data, error in
            
            guard let data = data else { completion(error); return }
            
            do {
                let photos = try JSONDecoder().decode(Array<Photo>.self, from: data)
                self.currentPage += 1
                self.nextPage += 1
                self.photoData != nil ? self.photoData!.append(contentsOf: photos) : (self.photoData = photos)
            } catch let error {
                completion(error)
                print(error.localizedDescription)
            }
        }
    }
}
