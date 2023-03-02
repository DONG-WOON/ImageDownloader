//
//  ImageDownloader.swift
//  ImageDownloader
//
//  Created by 서동운 on 2/22/23.
//

import UIKit

class ImageDownloader {
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func downloadImage(stringURL: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let url = URL(string: stringURL)!
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            switch httpResponse.statusCode {
            case (200...299):
                guard let data = data, let image = UIImage(data: data) else {
                    completion(.failure(ImageDownloaderError.noData))
                    return
                }
                completion(.success(image))
            case (400...499):
                completion(.failure(ImageDownloaderError.badRequest))
            default:
                completion(.failure(ImageDownloaderError.unknownError(httpResponse.statusCode)))
            }
        }
        task.resume()
    }
    
    enum ImageDownloaderError: Error {
        typealias StatusCode = Int
        case unknownError(StatusCode)
        case badRequest
        case noData
    }
}
