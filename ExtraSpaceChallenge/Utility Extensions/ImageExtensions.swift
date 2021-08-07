//
//  ImageExtensions.swift
//  ExtraSpaceChallenge
//
//  Created by orion on 8/6/21.
//

import UIKit

extension UIImage {
    
    /// A static extention on UIImage to get (download or from cache) an image by its url
    /// - Parameters:
    ///   - url: URL representing the location of the image
    ///   - completion: Completes with the image from the url or nil if not image is available
    public static func getPhotoForURL(url: URL, completion: @escaping (UIImage?) -> ()) {
        
        guard let image = getPhotoFromCache(with: url.absoluteString) else {
            
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: url) else { completion(nil); return }
                
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            return
        }
        
        completion(image)
    }
    
    /// Checks an image cache to determine if there is a photo cached for the url
    /// - Parameter urlString: String representation of the url for the photo
    /// - Returns: The image in the cache or nil if there is none
    public static func getPhotoFromCache(with urlString: String) -> UIImage? {
        if let dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String : String] {
            if let path = dict[urlString] {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                    let image = UIImage(data: data)
                    return image
                }
            }
        }
        
        return nil
    }
    
    /// A extention on UIImage to cache an image using a string representation of its url
    /// - Parameters:
    ///   - urlString: URL representing the location of the image
    public func cache(with urlString: String) {
        let path = NSTemporaryDirectory().appending(UUID().uuidString) // A path representing the temporary location of the cached image
        let url = URL(fileURLWithPath: path)
        
        let data = self.jpegData(compressionQuality: 0.8)
        try? data?.write(to: url)
        
        var dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String : String]
        
        if dict == nil {
            dict = [String : String]()
        }
        
        // Using the provided urlString as the key we story the path to the image
        // and then save it as a key, value pair in UserDefaults for loading later.
        dict![urlString] = path
        UserDefaults.standard.setValue(dict, forKey: "ImageCache")
    }
}
