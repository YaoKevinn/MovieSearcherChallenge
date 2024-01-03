//
//  ImageDownloadHelper.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 03/01/2024.
//

import Foundation

class ImageDownloader {
    static func downloadImage(from url: URL, completion: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            completion(data)
        }.resume()
    }
}

