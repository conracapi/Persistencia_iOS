import Foundation

struct Band {
    let name: String
    let members: [Artist]
    let albums: [Album]
}

extension Band {
    init(dto: BandDTO) {
        // name
        self.name = dto.name
        // members
        var membersList: [Artist] = []
        for member in dto.members {
            let newArtist = Artist(dto: member)
            membersList.append(newArtist)
        }
        self.members = membersList
        // albums
        var albumsList: [Album] = []
        for album in dto.albums {
            let newAlbum = Album(dto: album)
            albumsList.append(newAlbum)
        }
        self.albums = albumsList
    }
}

extension Band: Identifiable {
    var id: String {
        name
    }
}

extension Band {
    func bandName() -> String {
        return name
    }
    
    func bandMembers() -> String {
        let memberNames = members.map { currentMember in
            currentMember.name
        }
        let formattedMemberNames = memberNames.joined(separator: ", ")
        return formattedMemberNames
    }
}
