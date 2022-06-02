import Foundation


class ContentViewModel: ObservableObject {
    
    @Published var bands: [Band] = []
    @Published var albums: [Album] = []
    
    // Bandas
    private let getAllBands: GetAllBandsUseCaseProtocol = GetAllBandsUseCaseREAL()
    private let saveBand: SaveBandUseCaseProtocol = SaveBandUseCaseREAL()
    private let deleteAllBands: DeleteAllBandsUseCaseProtocol = DeleteAllBandsUseCaseREAL()
    private let deleteBands: DeleteBandsUseCaseProtocol = DeleteBandsUseCaseREAL()
    
    // Álbumes
    private let getAllAlbumsOfBand: GetAllAlbumsOfBandUseCaseProtocol = GetAllAlbumsOfBandUseCaseREAL()
    private let saveAlbumOfBand: SaveAlbumOfBandUseCaseProtocol = SaveAlbumOfBandUseCaseREAL()
    private let deleteAlbumOfBand: DeleteAlbumOfBandUseCaseProtocol = DeleteAlbumOfBandUseCaseREAL()
    private let deleteAllAlbumsOfBand: DeleteAllAlbumsOfBandUseCaseProtocol = DeleteAllAlbumsOfBandoUseCaseREAL()
    
    /*  =====================================  */
    /*  =====  MÉTODOS PARA LAS BANDAS  =====  */
    /*  =====================================  */
    
    func getSavedArtists() {
        getAllBands.execute { retrievedBands in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.bands = retrievedBands
            }
        }
    }
    
    func saveNewBand(band: Band) {
        saveBand.execute(band: band, completionHandler: { savedBandData in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.bands.append(savedBandData)
            }
        })
    }
    
    func deleteEveryBand() {
        deleteAllBands.execute(completionHandler: {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.bands = []
            }
        })
    }
    
    func deleteBands(bandIds: [String]) {
        deleteBands.execute(bandIds: bandIds, completionHandler: { removedBandIds in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.bands = self.bands
                    .filter { !removedBandIds.contains($0.id) }
            }
        })
    }
    
    
    /*  ====================================================  */
    /*  =====  MÉTODOS PARA LOS ÁLBUMES DE LAS BANDAS  =====  */
    /*  ====================================================  */
    
    func getAllAlbumsOfBand (band: Band) {
        getAllAlbumsOfBand.execute(band: band) { retrievedAlbums in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.albums = retrievedAlbums
            }
        }
    }
    
    func saveAlbumOfBand(band: Band, album: Album) {
        saveAlbumOfBand.execute(band: band, album: album) { savedAlbum in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.albums.append(savedAlbum)
            }
        }
    }
    
    func deleteAlbumsOfBand(albumIds: [String]) {
        deleteAlbumOfBand.execute(albumIds: albumIds, completionHandler: { removedAlbumIds in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.albums = self.albums
                    .filter { !removedAlbumIds.contains($0.id) }
            }
        })
    }
    
    func deletAllAlbumsOfBand() {
        deleteAllAlbumsOfBand.execute(completionHandler: {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.albums = []
            }
        })
        
    }
    
    
    
    
}



