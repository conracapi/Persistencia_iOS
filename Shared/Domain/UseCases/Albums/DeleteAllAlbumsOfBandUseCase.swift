//
//  DeleteAllAlbumsOfBandUseCase.swift
//  ArtistsZero
//
//  Created by Conrado Capilla García on 2/6/22.
//

import Foundation

protocol DeleteAllAlbumsOfBandUseCaseProtocol {
    func execute(completionHandler: @escaping (() -> Void))
}

struct DeleteAllAlbumsOfBandoUseCaseREAL: DeleteAllAlbumsOfBandUseCaseProtocol {
    
    private let repository: AlbumRepositoryProtocol = AlbumRepositoryREAL()
    
    func execute(completionHandler: @escaping (() -> Void)) {
        repository.deleteAllAlbumsOfBand(completionHandler: completionHandler)
    }
}

