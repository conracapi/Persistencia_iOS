//
//  GetAllAlbumsOfBandUseCase.swift
//  ArtistsZero
//
//  Created by Conrado Capilla García on 2/6/22.
//

import Foundation

protocol GetAllAlbumsOfBandUseCaseProtocol {
    func execute(band: Band, completionHandler: @escaping (([Album]) -> Void))
}

struct GetAllAlbumsOfBandUseCaseREAL: GetAllAlbumsOfBandUseCaseProtocol {
    
    private let repository: AlbumRepositoryProtocol = AlbumRepositoryREAL()
    
    func execute(band: Band, completionHandler: @escaping (([Album]) -> Void)) {
        repository.getAllAlbumsOfBand(band: band, completionHandler: completionHandler)
    }
    
}
