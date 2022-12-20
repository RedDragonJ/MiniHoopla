//
//  MovieCell.swift
//  MiniHoopla
//
//  Created by James Layton on 12/20/22.
//

import SwiftUI

struct MovieCell: View {
    
    @EnvironmentObject var appState: AppState
    
    @ObservedObject var moviesProcessor: MoviesProcessor
    let movie: Movie

    @State var image = UIImage()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 220)
                .cornerRadius(10)
            
            HStack {
                Image(systemName: "video.fill")
                    .resizable()
                    .frame(width: 15, height: 10)
                Text(movie.kind)
                    .font(.caption)
            }
            
            Text(movie.title)
                .font(.headline)
            Text(movie.artistName)
                .font(.caption)
        }
        .task {
            do {
                appState.isTaskLoading = true
                image = try await moviesProcessor.getImage(URLComponents.apiBuilder(artKey: movie.artKey))
                appState.isTaskLoading = false
            } catch let error {
                appState.isTaskLoading = false
                NotificationCenter.default.showAlert(AlertDetails(title: K.Alert.errorTitle,
                                                                  message: error.localizedDescription))
            }
        }
        .foregroundColor(Color(uiColor: .label))
        .padding()
    }
}

struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieCell(moviesProcessor: MoviesProcessor(),
                  movie: Movie(id: 1, title: "", kind: "", kindName: "",
                               artistName: "", demo: true, productionAssist: false, edited: false,
                               artKey: "", year: 1, children: true, fixedLayout: false,
                               readAlong: false))
    }
}
