import Foundation

protocol GetAllBandsUseCaseProtocol {
    func execute(completionHandler: @escaping ( ([Band]) -> Void ))
}

struct GetAllBandsUseCaseREAL: GetAllBandsUseCaseProtocol {
    private let repository: ArtistRepositoryProtocol = ArtistRepositoryREAL()
    
    func execute(completionHandler: @escaping ( ([Band]) -> Void )) {
        repository.getAllBands(completionHandler: completionHandler)
    }
}
