//
//  AlbumLocalDSProtocol.swift
//  ArtistsZero
//
//  Created by Conrado Capilla García on 2/6/22.
//

import Foundation

protocol AlbumLocalDSProtocol {
    func getAllAlbumsOfBand(band: BandDTO, completionHandler: @escaping (([AlbumDTO]) -> Void))
    func saveAlbumOfBand(band: BandDTO, album: AlbumDTO, completionHandler: @escaping ((AlbumDTO) -> Void))
    func deleteAllAlbumsOfBand(completionHandler: @escaping (() -> Void))
    func deleteAlbumOfBand(albumIds: [String], completionHandler: @escaping (([String]) -> Void))
}

struct AlbumLocalDSREAL: AlbumLocalDSProtocol {
    
    private let pController: PersistenceControllerProtocol = PersistenceController.shared
    
    func getAllAlbumsOfBand(band: BandDTO, completionHandler: @escaping (([AlbumDTO]) -> Void)) {
        pController.getAlbumsOfBand(band: band, completionHandler: completionHandler)
    }
    
    func saveAlbumOfBand(band: BandDTO, album: AlbumDTO, completionHandler: @escaping ((AlbumDTO) -> Void)) {
        pController.saveAlbumOfBand(band: band, album: album, completionHandler: completionHandler)
    }
    
    func deleteAllAlbumsOfBand(completionHandler: @escaping (() -> Void)) {
        pController.deleteAllAlbumsOfBand(completionHandler: completionHandler)
    }
    
    func deleteAlbumOfBand(albumIds: [String], completionHandler: @escaping (([String]) -> Void)) {
        pController.deleteAlbumOfBand(albumIds: albumIds, completionHandler: completionHandler)
    }
}
