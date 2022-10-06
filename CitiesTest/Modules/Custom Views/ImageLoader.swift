//
//  ImageLoader.swift
//  CitiesTest
//
//  Created by Aleksandr on 05.10.2022.
//

import UIKit
import Alamofire

let imageCache = NSCache<AnyObject, AnyObject>()

final class ImageLoader: UIImageView {
    func downloadImageFrom(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        downloadImageFrom(url: url)
    }
    
    func downloadImageFrom(url: URL) {
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage{
            self.image = imageFromCache
        } else {
            AF.request(url, method: .get).response { (responseData) in
                if let data = responseData.data {
                    DispatchQueue.main.async {
                        if let imageToCache = UIImage(data: data){
                            imageCache.setObject(imageToCache, forKey: url as AnyObject)
                            self.image = imageToCache
                        }
                    }
                }
            }
        }
    }
}
