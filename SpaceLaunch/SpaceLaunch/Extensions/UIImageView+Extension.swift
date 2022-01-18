//
//  UIImageView+Extension.swift
//  SpaceLaunch
//
//  Created by Sheethal Karkera on 17/1/22.
//

import UIKit

extension UIImageView {
    
    func downloadImage(urlString: String?, placeHolderImage: UIImage?) {
        
        if self.image == nil {
            self.image = placeHolderImage
        }
        
        guard let urlString = urlString,
              let imageURL = URL(string: urlString)
        else {
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error  in
            guard let self = self,
                  let data = data,
                  error == nil else {
                      return
                  }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.image = image
            }
        }.resume()
        
    }
}
