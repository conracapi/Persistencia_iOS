import CoreData

protocol PersistenceControllerProtocol {
    // Bandas
    func getAllBands(completionHandler: @escaping (([BandDTO]) -> Void))
    func saveBand(band: BandDTO, completionHandler: @escaping ((BandDTO) -> Void))
    func removeAllBands(completionHandler: @escaping (() -> Void))
    func deleteBands(bandIds: [String], completionHandler: @escaping ( ([String]) -> Void ))
    // Álbumes
    func getAlbumsOfBand(band: BandDTO, completionHandler: @escaping (([AlbumDTO]) -> Void))
    func saveAlbumOfBand(band: BandDTO, album: AlbumDTO, completionHandler: @escaping ((AlbumDTO) -> Void))
    func deleteAlbumOfBand(albumIds: [String], completionHandler: @escaping (([String]) -> Void))
    func deleteAllAlbumsOfBand(completionHandler: @escaping (() -> Void))
}

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ArtistsZero")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

extension PersistenceController: PersistenceControllerProtocol {
    
    /*  =====================================  */
    /*  =====  MÉTODOS PARA LAS BANDAS  =====  */
    /*  =====================================  */
    
    func getAllBands(completionHandler: @escaping (([BandDTO]) -> Void)) {
        container.performBackgroundTask { privateMOC in
            let request = CDBand.fetchRequest()
            request.predicate = nil
            var retrievedBands: [CDBand] = []
            do {
                retrievedBands = try privateMOC.fetch(request)
            } catch {
                print("F: \(error)")
                completionHandler([])
            }
            let transformedDtosB = retrievedBands.map { currentCDBand in
                BandDTO(cd: currentCDBand)
            }
            completionHandler(transformedDtosB)
        }
    }
    
    func saveBand(band: BandDTO, completionHandler: @escaping ((BandDTO) -> Void) ) {
        container.performBackgroundTask { privateMOC in
            let request = CDBand.fetchRequest()
            request.predicate = nil
            let newBand = CDBand(context: privateMOC)
            newBand.name = band.name
            newBand.id = band.id
            band.members.forEach { currentArtistDto in
                let newArtist = CDArtist(context: privateMOC)
                newArtist.name = currentArtistDto.name
                newArtist.birthDate = currentArtistDto.birthDate
                newArtist.addToBelongs(newBand)
            }
            band.albums.forEach { currentAlbumDto in
                let newAlbum = CDAlbum(context: privateMOC)
                newAlbum.name = currentAlbumDto.name
                newAlbum.numberOfSongs = currentAlbumDto.numberOfSongs
                newAlbum.year = currentAlbumDto.year
                newAlbum.addToCorresponds(newBand)
            }
            do {
                try privateMOC.save()
            } catch {
                print("F: \(error)")
            }
            completionHandler(band)
        }
    }
    
    func removeAllBands(completionHandler: @escaping (() -> Void)) {
        container.performBackgroundTask { privateMOC in
            let request: NSFetchRequest<NSFetchRequestResult> = CDBand.fetchRequest()
            request.predicate = nil
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            do {
                try privateMOC.execute(deleteRequest)
            } catch {
                print("F: \(error)")
            }
            completionHandler()
        }
    }
    
    func deleteBands(bandIds: [String], completionHandler: @escaping (([String]) -> Void)) {
        container.performBackgroundTask { privateMOC in
            let request: NSFetchRequest<NSFetchRequestResult> = CDBand.fetchRequest()
            request.predicate = NSPredicate(format: "id IN %@", bandIds)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            deleteRequest.resultType = .resultTypeCount
            do {
                _ = try privateMOC.execute(deleteRequest) as? NSBatchDeleteResult
            } catch {
                print("F: \(error)")
            }
            completionHandler(bandIds)
        }
    }
    
    
    
    /*  ====================================================  */
    /*  =====  MÉTODOS PARA LOS ÁLBUMES DE LAS BANDAS  =====  */
    /*  ====================================================  */
    
    func getAlbumsOfBand(band: BandDTO, completionHandler: @escaping (([AlbumDTO]) -> Void)) {
        container.performBackgroundTask { privateMOC in
            /* Se obtienen todas las bandas almacenadas */
            let request = CDBand.fetchRequest()
            request.predicate = nil
            var retrievedBands: [CDBand] = []
            do {
                retrievedBands = try privateMOC.fetch(request)
            } catch {
                print("F: \(error)")
                completionHandler([])
            }
            /* Se guarda la banda sobre la que se quiere conseguir los álbumes */
            var selectedBand: CDBand?
            for cdBand in retrievedBands {
                if (cdBand.name == band.name) {
                    selectedBand = cdBand
                }
            }
            /* Se obtienen todos los álbumes de esa banda */
            let retrievedCDAlbums = selectedBand?.albums?.allObjects ?? []
            print ("El número de álbumes de la banda es de ... : \(retrievedCDAlbums.count)")
            /* Se hace la conversión a CDAlbum */
            let cdAlbumArray = retrievedCDAlbums
                .compactMap { currentAny in
                    currentAny as? CDAlbum
                }
            /* Se hace la conversión a AlbumDTO */
            let albumsDTO = cdAlbumArray
                .map { currentCDAlbum in
                    AlbumDTO(cd: currentCDAlbum)
                }
            completionHandler(albumsDTO)
        }
    }
    
    
    func saveAlbumOfBand(band: BandDTO, album: AlbumDTO, completionHandler: @escaping ((AlbumDTO) -> Void)) {
        container.performBackgroundTask { privateMOC in
            /* Se obtienen todas las bandas almacenadas */
            let request = CDBand.fetchRequest()
            request.predicate = nil
            var retrievedBands: [CDBand] = []
            do {
                retrievedBands = try privateMOC.fetch(request)
            } catch {
                print("F: \(error)")
            }
            /* Se guarda la banda sobre la que se quiere añadir el álbum */
            var selectedBand: CDBand = CDBand()
            for cdBand in retrievedBands {
                if (cdBand.name == band.name) {
                    selectedBand = cdBand
                }
            }
            /* Se crea el CDAlbum con el album que viene de parámetro */
            let newAlbumToAdd = CDAlbum(context: privateMOC)
            newAlbumToAdd.name = album.name
            newAlbumToAdd.numberOfSongs = album.numberOfSongs
            newAlbumToAdd.year = album.year
            /* Se añade el álbum a la relación de la banda */
            newAlbumToAdd.addToCorresponds(selectedBand)
            /* Se ejecuta */
            do {
                try privateMOC.save()
            } catch {
                print("F: \(error)")
            }
            let addedAlbum = AlbumDTO(cd: newAlbumToAdd)
            completionHandler(addedAlbum)
        }
    }
    
    func deleteAlbumOfBand(albumIds: [String], completionHandler: @escaping (([String]) -> Void)) {
        container.performBackgroundTask { privateMOC in
            let request: NSFetchRequest<NSFetchRequestResult> = CDAlbum.fetchRequest()
            request.predicate = NSPredicate(format: "name IN %@", albumIds)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            deleteRequest.resultType = .resultTypeCount
            do {
                _ = try privateMOC.execute(deleteRequest) as? NSBatchDeleteResult
            } catch {
                print("F: \(error)")
            }
            completionHandler(albumIds)
        }
    }
    
    
    func deleteAllAlbumsOfBand(completionHandler: @escaping (() -> Void)) {
        container.performBackgroundTask { privateMOC in
            let request: NSFetchRequest<NSFetchRequestResult> = CDAlbum.fetchRequest()
            request.predicate = nil
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            do {
                try privateMOC.execute(deleteRequest)
            } catch {
                print("F: \(error)")
            }
            completionHandler()
        }
    }
    
    
    
}
