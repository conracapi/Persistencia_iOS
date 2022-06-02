import Foundation

protocol DeleteAllBandsUseCaseProtocol {
    func execute(completionHandler: @escaping ( () -> Void ))
}

struct DeleteAllBandsUseCaseREAL: DeleteAllBandsUseCaseProtocol {
    private let repository: ArtistRepositoryProtocol = ArtistRepositoryREAL()
    
    func execute(completionHandler: @escaping ( () -> Void )) {
        repository.removeAllBands(completionHandler: completionHandler)
    }
}
