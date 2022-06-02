import Foundation

struct ArtistDTO {
    let name: String
    let birthDate: Date
}

extension ArtistDTO {
    init(domain: Artist) {
        self.name = domain.name
        self.birthDate = domain.birthDate
    }
}

extension ArtistDTO {
    init(cd: CDArtist) {
        self.name = cd.name!
        self.birthDate = cd.birthDate!
    }
}
