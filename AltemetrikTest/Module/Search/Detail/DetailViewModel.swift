//
//  DetailViewModel.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 28/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

protocol DetailViewModelProtocol: ViewModel, ImageDownloadingProtocol {
    var artistName: String? { get }
    var artistTrack: String? { get }
    var collectionName: String? { get }
    var trackPrice: Double? { get }
    var collectionPrice: Double? { get }
    var imageData: Data? { get set }
    var country: String? { get }
    var primaryGenre: String? { get }
    var formattedDate: String? { get }
}

protocol ImageDownloadingProtocol: class {
    func downLoadImageFromString(onCompletion: @escaping (_ data: Data?) -> ())
}

extension ArtistCellViewModel: DetailViewModelProtocol {
    
    var formattedDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        guard let date = releaseDate else {
            return nil
        }
        return dateFormatter.string(from: date)
    }
}

extension ArtistCellViewModel {
    
    func downLoadImageFromString(onCompletion: @escaping (Data?) -> ()) {
        guard imageData == nil,
            let stringUrl = imageUrl,
            let url = URL(string: stringUrl)  else { return }
        URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let imgData = data {
                    self?.imageData = imgData
                    onCompletion(imgData)
                } else {
                    onCompletion(nil)
                }
            }
        }.resume()
    }
}
