import Foundation

protocol DeleteBandsUseCaseProtocol {
    func execute(bandIds: [String], completionHandler: @escaping ( ([String]) -> Void ))
}

struct DeleteBandsUseCaseREAL: DeleteBandsUseCaseProtocol {
    private let repository: ArtistRepositoryProtocol = ArtistRepositoryREAL()
    
    func execute(bandIds: [String], completionHandler: @escaping ( ([String]) -> Void )) {
        repository.deleteBands(bandIds: bandIds, completionHandler: completionHandler)
    }
}
