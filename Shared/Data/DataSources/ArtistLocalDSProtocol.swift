import Foundation

protocol ArtistLocalDSProtocol {
    func getAllBands(completionHandler: @escaping ( ([BandDTO]) -> Void ) )
    func save(band: BandDTO, completionHandler: @escaping ((BandDTO) -> Void) )
    func removeAllBands(completionHandler: @escaping ( () -> Void ))
    func deleteBands(bandIds: [String], completionHandler: @escaping ( ([String]) -> Void ))
}

struct ArtistLocalDSREAL: ArtistLocalDSProtocol {
    private let pController: PersistenceControllerProtocol = PersistenceController.shared
    
    func getAllBands(completionHandler: @escaping ( ([BandDTO]) -> Void ) ) {
        pController.getAllBands(completionHandler: completionHandler)
    }
    
    func save(band: BandDTO, completionHandler: @escaping ((BandDTO) -> Void) ) {
        pController.saveBand(band: band, completionHandler: completionHandler)
    }
    
    func removeAllBands(completionHandler: @escaping ( () -> Void )) {
        pController.removeAllBands(completionHandler: completionHandler)
    }
    
    func deleteBands(bandIds: [String], completionHandler: @escaping ( ([String]) -> Void )) {
        pController.deleteBands(bandIds: bandIds, completionHandler: completionHandler)
    }
}
