//
//  MovieCollection.swift
//  MiniHoopla
//
//  Created by James Layton on 12/20/22.
//

import SwiftUI

struct MovieCollection: View {
    
    @EnvironmentObject var appState: AppState
    
    @StateObject private var moviesProcessor = MoviesProcessor()
    
    @State private var showAlert = false
    @State private var alertDetails: AlertDetails?
    
    private var doubleGridLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: doubleGridLayout, spacing: 16) {
                        if let movies = moviesProcessor.movies {
                            ForEach(movies, id: \.self) { movie in
                                NavigationLink {
                                    MovieDetails(moviesProcessor: moviesProcessor, movie: movie)
                                } label: {
                                    MovieCell(moviesProcessor: moviesProcessor, movie: movie)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Movies")
            }
            .task {
                do {
                    appState.isTaskLoading = true
                    try await moviesProcessor.getMovies(URLComponents.apiBuilder())
                    appState.isTaskLoading = false
                } catch let error {
                    appState.isTaskLoading = false
                    NotificationCenter.default.showAlert(AlertDetails(title: K.Alert.errorTitle,
                                                                      message: error.localizedDescription))
                }
            }
            
            SpinnerView(isVisible: appState.isTaskLoading)
        }
        .onReceive(NotificationCenter.default.publisher(for: .showAlert)) { notification in
            if let alertDetails = notification.object as? AlertDetails {
                self.alertDetails = alertDetails
                showAlert = true
            }
        }
        .alert(Text(""), isPresented: $showAlert, presenting: alertDetails) { detail in
            ForEach(detail.buttons, id: \.title) { button in
                Button("\(button.title)") {
                    button.action()
                }
            }
        } message: { detail in
            Text("\(detail.message)")
        }
    }
}

struct MovieCollection_Previews: PreviewProvider {
    static var previews: some View {
        MovieCollection()
    }
}
