import Foundation

struct BandDTO {
    let id: String
    let name: String
    let members: [ArtistDTO]
    let albums: [AlbumDTO]
}

extension BandDTO {
    init(domain: Band) {
        self.id = domain.id
        self.name = domain.name
        self.members = domain.members.map { currentArtist in
            ArtistDTO(domain: currentArtist)
        }
        self.albums = domain.albums.map { currentAlbum in
            AlbumDTO(domain: currentAlbum)
        }
    }
}

extension BandDTO {
    init(cd: CDBand) {
        // id
        self.id = cd.id!
        // name
        self.name = cd.name!
        // members
        let retrievedArrayMembers = cd.members?.allObjects ?? []
        let cdArtistArray = retrievedArrayMembers
            .compactMap { currentAny in
                currentAny as? CDArtist
            }
        self.members = cdArtistArray
            .map { currentCDArtist in
                ArtistDTO(cd: currentCDArtist)
            }
        // albums
        let retrievedArrayAlbums = cd.albums?.allObjects ?? []
        let cdAlbumArray = retrievedArrayAlbums
            .compactMap { currentAny in
                currentAny as? CDAlbum
            }
        self.albums = cdAlbumArray
            .map { currentCDAlbum in
                AlbumDTO(cd: currentCDAlbum)
            }
    }
}
