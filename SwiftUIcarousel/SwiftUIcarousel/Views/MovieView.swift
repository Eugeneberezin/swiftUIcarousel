//
//  MovieView.swift
//  SwiftUIcarousel
//
//  Created by Eugene Berezin on 11/16/21.
//

import SwiftUI

struct MovieView: View {
    
    let movie: Result
    let screenSize: CGSize
    
    let width: CGFloat
    let height: CGFloat = 400
    
    var body: some View {
        GeometryReader { reader in
            let midX = reader.frame(in: .global).midX
            let distance = abs(screenSize.width / 2 - midX)
            let damping: CGFloat = 4.5
            let percentage = abs(distance / (screenSize.width / 2) / damping - 1)
            let baseImageURL = "https://image.tmdb.org/t/p/w500"
            let poster: String = movie.posterPath ?? ""
            let url = URL(string: baseImageURL + poster)
            
            VStack {
                Spacer()
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(width: width)
                    case .empty:
                        ZStack {
                            Color.blue
                            VStack {
                                Text("Image is not available")
                                    .foregroundColor(.white)
                                Text(movie.originalTitle ?? "Title is not available")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                            }
                        }
                        .padding()
                        .frame(width: width - 50, height: height, alignment: .center)
                    case .failure(_):
                        ZStack {
                            Color.blue
                            VStack {
                                Text("Image is not available")
                                    .foregroundColor(.white)
                                Text(movie.originalTitle ?? "Title is not available")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                            }
                        }
                        .padding()
                        .frame(width: width - 50, height: height, alignment: .center)
                    @unknown default:
                        ZStack {
                            Color.blue
                            VStack {
                                Text("Image is not available")
                                    .foregroundColor(.white)
                                Text(movie.originalTitle ?? "Title is not available")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                            }
                        }
                        .padding()
                        .frame(width: width - 50, height: height, alignment: .center)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .scaleEffect(percentage)
            .shadow(color: Color(.sRGBLinear, white: 0.1, opacity: 0.33), radius: 50, x: 5, y: 5)
            

            
        }
        .frame(width: width, height: height)
    }
}
