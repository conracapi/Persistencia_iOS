//
//  Album.swift
//  ArtistsZero
//
//  Created by Conrado Capilla García on 2/6/22.
//

import Foundation

struct Album {
    let name: String
    let numberOfSongs: String
    let year: String
}


extension Album {
    init(dto: AlbumDTO) {
        self.name = dto.name
        self.numberOfSongs = dto.numberOfSongs
        self.year = dto.year
    }
}

extension Album: Identifiable {
    var id: String {
        name
    }
}
