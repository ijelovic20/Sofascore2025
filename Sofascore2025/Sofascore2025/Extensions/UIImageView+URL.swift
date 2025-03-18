//
//  UIImageView.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 16.03.2025..
//

import UIKit

extension UIImageView {
    func setImageURL(_ url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
