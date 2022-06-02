import Foundation

protocol SaveBandUseCaseProtocol {
    func execute(band: Band, completionHandler: @escaping ((Band) -> Void) )
}

struct SaveBandUseCaseREAL: SaveBandUseCaseProtocol {
    private let repository: ArtistRepositoryProtocol = ArtistRepositoryREAL()
    
    func execute(band: Band, completionHandler: @escaping ((Band) -> Void) ) {
        repository.save(band: band, completionHandler: completionHandler)
    }
}
