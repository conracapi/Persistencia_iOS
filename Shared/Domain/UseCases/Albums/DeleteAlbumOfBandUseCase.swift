//
//  DeleteAlbumOfBandUseCase.swift
//  ArtistsZero
//
//  Created by Conrado Capilla García on 2/6/22.
//

import Foundation

protocol DeleteAlbumOfBandUseCaseProtocol {
    func execute(albumIds: [String], completionHandler: @escaping (([String]) -> Void))
}

struct DeleteAlbumOfBandUseCaseREAL: DeleteAlbumOfBandUseCaseProtocol {
    
    private let repository: AlbumRepositoryProtocol = AlbumRepositoryREAL()
    
    func execute(albumIds: [String], completionHandler: @escaping (([String]) -> Void)) {
        repository.deleteAlbumOfBand(albumIds: albumIds, completionHandler: completionHandler)
    }
}

