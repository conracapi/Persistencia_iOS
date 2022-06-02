//
//  AlbumDTO.swift
//  ArtistsZero
//
//  Created by Conrado Capilla García on 2/6/22.
//

import Foundation


struct AlbumDTO {
    let name: String
    let numberOfSongs: String
    let year: String
}

extension AlbumDTO {
    init(domain: Album) {
        self.name = domain.name
        self.numberOfSongs = domain.numberOfSongs
        self.year = domain.year
    }
}

extension AlbumDTO {
    init(cd: CDAlbum) {
        self.name = cd.name!
        self.numberOfSongs = cd.numberOfSongs!
        self.year = cd.year!
    }
}
