//
//  AlbumRepository.swift
//  ArtistsZero
//
//  Created by Conrado Capilla García on 2/6/22.
//

import Foundation

protocol AlbumRepositoryProtocol {
    func getAllAlbumsOfBand(band: Band, completionHandler: @escaping (([Album]) -> Void))
    func saveAlbumOfBand(band: Band, album: Album, completionHandler: @escaping ((Album) -> Void))
    func deleteAlbumOfBand(albumIds: [String], completionHandler: @escaping (([String]) -> Void))
    func deleteAllAlbumsOfBand(completionHandler: @escaping (() -> Void))
}

struct AlbumRepositoryREAL: AlbumRepositoryProtocol {
    
    private let localDataSource: AlbumLocalDSProtocol = AlbumLocalDSREAL()
    
    func getAllAlbumsOfBand(band: Band, completionHandler: @escaping (([Album]) -> Void)) {
        let bandDto = BandDTO(domain: band)
        localDataSource.getAllAlbumsOfBand(band: bandDto, completionHandler: { albumsDto in
            let domainAlbums = albumsDto.map { currentAlbumDto in
                Album(dto: currentAlbumDto)
            }
            completionHandler(domainAlbums)
        })
    }
    
    func saveAlbumOfBand(band: Band, album: Album, completionHandler: @escaping ((Album) -> Void)) {
        let bandDto = BandDTO(domain: band)
        let albumDto = AlbumDTO(domain: album)
        localDataSource.saveAlbumOfBand(band: bandDto, album: albumDto, completionHandler: { albumDto in
            completionHandler(Album(dto: albumDto))
        })
        
    }
    
    func deleteAlbumOfBand(albumIds: [String], completionHandler: @escaping (([String]) -> Void)) {
        localDataSource.deleteAlbumOfBand(albumIds: albumIds, completionHandler: completionHandler)
    }
    
    func deleteAllAlbumsOfBand(completionHandler: @escaping (() -> Void)) {
        localDataSource.deleteAllAlbumsOfBand(completionHandler: completionHandler)
    }
}
