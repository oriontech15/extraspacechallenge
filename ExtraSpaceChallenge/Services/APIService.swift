//
//  APIService.swift
//  ExtraSpaceChallenge
//
//  Created by orion on 8/6/21.
//

import Foundation


class APIService {
    
    /// A simple service method to retrieve data from a URL
    /// - Parameters:
    ///   - urlRequest: A URLRequest object representing more information for the specified url
    ///   - completion: Completion closure to be executed when the data task completes. Includes the returned data
    /// - Returns: Data returned from the url or nil if no data was returned
    func fetchDataFor(urlRequest: URLRequest, completion: @escaping(_ data: Data?, _ error: Error?) -> ()) {
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            completion(data, nil)
            
        }.resume()
    }
}
