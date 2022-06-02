import Foundation

protocol ArtistRepositoryProtocol {
    func getAllBands(completionHandler: @escaping ( ([Band]) -> Void ))
    func save(band: Band, completionHandler: @escaping ((Band) -> Void) )
    func removeAllBands(completionHandler: @escaping ( () -> Void ))
    func deleteBands(bandIds: [String], completionHandler: @escaping ( ([String]) -> Void ))
}

struct ArtistRepositoryREAL: ArtistRepositoryProtocol {
    
    private let localDataSource: ArtistLocalDSProtocol = ArtistLocalDSREAL()
    
    func getAllBands(completionHandler: @escaping ( ([Band]) -> Void )) {
        localDataSource.getAllBands { bandsDtos in
            let domainBands = bandsDtos.map { currentBandDto in
                Band(dto: currentBandDto)
            }
            completionHandler(domainBands)
        }
    }
    
    func save(band: Band, completionHandler: @escaping ((Band) -> Void) ) {
        localDataSource.save(band: BandDTO(domain: band),
                             completionHandler: { bandDto in
            completionHandler(Band(dto: bandDto))
        })
    }
    
    func removeAllBands(completionHandler: @escaping ( () -> Void )) {
        localDataSource.removeAllBands(completionHandler: completionHandler)
    }
    
    func deleteBands(bandIds: [String], completionHandler: @escaping ( ([String]) -> Void )) {
        localDataSource.deleteBands(bandIds: bandIds, completionHandler: completionHandler)
    }
}


