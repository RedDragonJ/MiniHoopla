//
//  MovieDetails.swift
//  MiniHoopla
//
//  Created by James Layton on 12/20/22.
//

import SwiftUI

struct MovieDetails: View {
    
    @EnvironmentObject var appState: AppState
    
    @ObservedObject var moviesProcessor: MoviesProcessor
    let movie: Movie

    @State var movieDetail: MovieDetail?
    @State var image = UIImage()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                
                Image(uiImage: image)
                
                Text(movie.title)
                    .font(.title)
                
                HStack {
                    Image(systemName: "video.fill")
                        .resizable()
                        .frame(width: 15, height: 10)
                    Text(movie.kind)
                    
                    Spacer()
                    
                    Text("by \(movie.artistName)")
                }
                .font(.headline)
                .padding(.bottom, 16)
                
                if let movieDetail {
                    Text(movieDetail.synopsis)
                }
                
                Button("Play Movie") {
                    NotificationCenter.default.showAlert(AlertDetails(title: "",
                                                                      message: "Playing movie now....."))
                }
                .frame(maxWidth: 360, maxHeight: 40)
                .padding()
                .background(.blue)
                .foregroundColor(Color(uiColor: .label))
                .cornerRadius(15)
            }
            .padding()
        }
        .navigationTitle("Movie details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            do {
                appState.isTaskLoading = true
                movieDetail = try await moviesProcessor.getMovieDetails(URLComponents.apiBuilder(titleID: "\(movie.id)"))
                image = try await moviesProcessor.getImage(URLComponents.apiBuilder(artKey: movie.artKey))
                appState.isTaskLoading = false
            } catch let error {
                appState.isTaskLoading = false
                NotificationCenter.default.showAlert(AlertDetails(title: K.Alert.errorTitle,
                                                                  message: error.localizedDescription))
            }
        }
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails(moviesProcessor: MoviesProcessor(),
                     movie: Movie(id: 1, title: "", kind: "", kindName: "",
                                  artistName: "", demo: true, productionAssist: false,
                                  edited: false, artKey: "", year: 2, children: false,
                                  fixedLayout: false, readAlong: true))
    }
}
