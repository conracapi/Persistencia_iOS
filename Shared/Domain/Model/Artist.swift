import Foundation

struct Artist {
    let name: String
    let birthDate: Date
}

extension Artist {
    init(dto: ArtistDTO) {
        self.name = dto.name
        self.birthDate = dto.birthDate
    }
}

extension Artist: Identifiable {
    var id: String {
        name
    }
}
