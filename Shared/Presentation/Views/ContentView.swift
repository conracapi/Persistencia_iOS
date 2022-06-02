import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject private var viewModel = ContentViewModel()
    
//    let bandNames: [String] = [
//        "Dire Straits",
//        "Incubus",
//        "Queen",
//        "Rolling"
//    ]
    
    let memberNames: [String] = [
        "Freddy Mercury",
        "Mike Jagger",
        "James Hetfield",
        "Mark Knoffler"
    ]
    
    let albums: [Album] = [
        Album(name: "Thriller", numberOfSongs: "12", year: "1982"),
        Album(name: "Back in Black", numberOfSongs: "8", year: "1980"),
        Album(name: "Bat Out of Hell", numberOfSongs: "10", year: "1977"),
        Album(name: "The Dark Side of the Moon", numberOfSongs: "7", year: "1973"),
        Album(name: "The Bodyguard", numberOfSongs: "9", year: "1992"),
        Album(name: "Their Greatest Hits (1971-1975)", numberOfSongs: "14", year: "1976"),
        Album(name: "Rumours", numberOfSongs: "17", year: "1977"),
        Album(name: "Saturday Night Fever", numberOfSongs: "8", year: "1977"),
        Album(name: "El fantasma de la ópera", numberOfSongs: "10", year: "1986"),
        Album(name: "Come on Over", numberOfSongs: "11", year: "1997")
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.bands) { band in
                    NavigationLink {
                        
                        /*  ==================  */
                        /*  ===  ARTISTAS  ===  */
                        /*  ==================  */
                        
                        VStack (alignment: .leading) {
                            Text("ARTISTAS:")
                                .bold()
                                .font(.system(size: 21))
                                .padding([.leading], 20)
                            Spacer()
                                .frame(height: 5)
                            ForEach(band.members) { member in
                                Text("- \(member.name)")
                                    .font(.system(size: 18))
                                    .padding([.leading], 35)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.top], 30)
                        
                        /*  ===============================  */
                        /*  ===  SEPARACIÓN INTERMEDIA  ===  */
                        /*  ===============================  */
                        
                        Spacer()
                            .frame(height: 50)
                        
                        /*  =============================================  */
                        /*  ===  BOTÓN PARA BORRAR TODOS LOS ÁLBUMES  ===  */
                        /*  =============================================  */
                        
                        Button(action: {
                            viewModel.deletAllAlbumsOfBand()
                        }, label: {
                            Text("Borrar álbumes")
                                .foregroundColor(Color.red)
                        })
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding([.trailing], 20)
                        
                        /*  =================  */
                        /*  ===  ÁLBUMES  ===  */
                        /*  =================  */
                        
                        VStack (alignment: .leading) {
                            Text("ÁLBUMES:")
                                .bold()
                                .font(.system(size: 21))
                                .padding([.leading], 20)
                                .padding([.bottom], -1)
                            List {
                                ForEach(viewModel.albums) { album in
                                    Text(album.name)
                                }
                                .onDelete(perform: deleteAlbumOfBand)
                            }
                            .onAppear(perform: {
                                    UITableView.appearance().contentInset.top = -20
                                })
                            .onAppear { viewModel.getAllAlbumsOfBand(band: band) }
                            .padding([.top], 0)
                            .navigationBarTitle("Detalle de BANDA", displayMode: .inline)
                            .toolbar {
                                #if os(iOS)
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    EditButton()
                                }
                                #endif
                                ToolbarItem {
                                    Button(action: {
                                        addAlbumOfBand(band: band)
                                    }) {
                                        Label("Add Item", systemImage: "plus")
                                    }
                                }
                            }
                        }.frame(maxWidth: .infinity, alignment: .topLeading)
                        
                    } label: {
                        Text(band.bandName())
                    }
                }
                .onDelete(perform: deleteBands)
            }
            .navigationBarTitle("BANDAS", displayMode: .inline)
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                #endif
                ToolbarItem {
                    Button(action: addBand) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
        .onAppear {
            viewModel.getSavedArtists()
        }
    }

    
    
    
    
    /*  =====================================  */
    /*  =====  MÉTODOS PARA LAS BANDAS  =====  */
    /*  =====================================  */
    
    
    private func addBand() {
        withAnimation {
            let memberOneIndex = Int.random(in: 0..<4)
            let memberTwoIndex = Int.random(in: 0..<4)
            let members = [
                Artist(name: memberNames[memberOneIndex] , birthDate: Date()),
                Artist(name: memberNames[memberTwoIndex], birthDate: Date())
            ]
            // De inicio: mínimo 2 álbumes y máximo 5
            let albumOneIndex = albums[Int.random(in: 0..<10)]
            let albumTwoIndex = albums[Int.random(in: 0..<10)]
            let albumThreeIndex = albums[Int.random(in: 0..<10)]
            let addedAlbums = [albumOneIndex, albumTwoIndex, albumThreeIndex]
            let newBand = Band(name: UUID().uuidString, members: members, albums: addedAlbums)
            viewModel.saveNewBand(band: newBand)
        }
    }
    
    private func deleteBands(offsets: IndexSet) {
        withAnimation {
            let bandsToRemove = offsets.map {
                viewModel.bands[$0].id
            }
            viewModel.deleteBands(bandIds: bandsToRemove)
        }
    }
    
    
    /*  ====================================================  */
    /*  =====  MÉTODOS PARA LOS ÁLBUMES DE LAS BANDAS  =====  */
    /*  ====================================================  */
    
    private func addAlbumOfBand(band: Band) {
        withAnimation {
            let album = albums[Int.random(in: 0..<10)]
            viewModel.saveAlbumOfBand(band: band, album: album)
        }
    }
    
    private func deleteAlbumOfBand(offsets: IndexSet) {
        withAnimation {
            let albumsToRemove = offsets.map {
                viewModel.albums[$0].id
            }
            viewModel.deleteAlbumsOfBand(albumIds: albumsToRemove)
        }
    }
    
    
    
    
}

