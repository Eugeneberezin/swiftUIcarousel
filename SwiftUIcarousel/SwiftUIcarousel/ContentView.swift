//
//  ContentView.swift
//  SwiftUIcarousel
//
//  Created by Eugene Berezin on 11/8/21.
//

import SwiftUI

struct ContentView: View {
    @State private var searchTerm = ""
    @StateObject private var viewModel = ViewModel()
    let tabBarImages = ["house", "play.circle.fill", "bookmark.fill", "person.fill"]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack(spacing: 250) {
                    Text("Category")
                        .foregroundColor(.white)
                    Text("See all >")
                        .foregroundColor(.orange)
                }
                
                HStack(spacing: 40) {
                    VStack {
                        Text("😍")
                            .font(.title)
                            .padding(20)
                            .background {
                                Color("backGround")
                            }
                            .cornerRadius(12)
                        Text("Romance")
                            .foregroundColor(.white)
                    }
                    VStack {
                        Text("😄")
                            .font(.title)
                            .padding(20)
                            .background {
                                Color("backGround")
                            }
                            .cornerRadius(12)
                        Text("Comedy")
                            .foregroundColor(.white)
                    }
                    
                    VStack {
                        Text("😎")
                            .font(.title)
                            .padding(20)
                            .background(content: {
                                Color("backGround")
                            })
                            .cornerRadius(12)
                        
                        Text("Action")
                            .foregroundColor(.white)
                    }
                    
                    VStack {
                        Text("😱")
                            .font(.title)
                            .padding(20)
                        
                            .background(content: {
                                Color("backGround")
                            })
                            .cornerRadius(12)
                        
                        Text("Horror")
                            .foregroundColor(.white)
                    }
                    
                }
                Spacer(minLength: 30)
                
                Text("Favorite Movies")
                    .foregroundColor(.white)
                
                GeometryReader { screenReader in
                    let screenSize: CGSize = screenReader.size
                    moviesCarossouel(screenSize: screenSize)
                }
                .onAppear {
                    viewModel.getMovies(searchTerm: "Christmas")
                }
                
                HStack {
                    ForEach(tabBarImages.indices) { index in
                       Spacer()
                        Button {
                            //more code to come in the next livestream
                        } label: {
                            Image(systemName: tabBarImages[index])
                                .tint(.white)
                        }
                        Spacer()

                    }
                }
                .padding()
                .background {
                    Color("backGround")
                }
                .cornerRadius(8)
                .padding()
            }
            .background {
                Color.black
                    .ignoresSafeArea()
            }
            .searchable(text: $searchTerm)
            .navigationBarItems(
                leading: VStack(alignment: .leading, spacing: 5) {
                    Text("Hello Eugene")
                        .font(.title)
                        .foregroundColor(.white)
                    Text("What's your favorite movie?")
                        .font(.body)
                        .foregroundColor(.gray)
                }
            )
            
        }
    }
    
    func moviesCarossouel(screenSize: CGSize) -> some View {
        let itemWidth: CGFloat = screenSize.width * 0.8
        let padding: CGFloat = (screenSize.width - itemWidth) / 2
        
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: -100) {
                ForEach(viewModel.movies) {movie in
                    MovieView(movie: movie, screenSize: screenSize, width: itemWidth)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
