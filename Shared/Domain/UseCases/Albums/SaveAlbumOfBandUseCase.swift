//
//  SaveAlbumOfBandUseCase.swift
//  ArtistsZero
//
//  Created by Conrado Capilla García on 2/6/22.
//

import Foundation

protocol SaveAlbumOfBandUseCaseProtocol {
    func execute(band: Band, album: Album, completionHandler: @escaping ((Album) -> Void))
}

struct SaveAlbumOfBandUseCaseREAL: SaveAlbumOfBandUseCaseProtocol {
    
    private let repository: AlbumRepositoryProtocol = AlbumRepositoryREAL()
    
    func execute(band: Band, album: Album, completionHandler: @escaping ((Album) -> Void)) {
        repository.saveAlbumOfBand(band: band, album: album, completionHandler: completionHandler)
    }
}

