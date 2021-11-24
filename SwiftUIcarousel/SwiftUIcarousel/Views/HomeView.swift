//
//  HomeView.swift
//  SwiftUIcarousel
//
//  Created by Eugene Berezin on 11/23/21.
//

import SwiftUI

struct HomeView: View {
    @State private var searchTerm = "Search..."
    @EnvironmentObject private var viewModel: ViewModel
   
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                SearchBarView(text: $searchTerm)
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
            }
            .background {
                Color.black
                    .ignoresSafeArea()
            }
            .onChange(of: searchTerm, perform: { _ in
                viewModel.getMovies(searchTerm: searchTerm)
            })
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
       
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: -100) {
                ForEach(viewModel.movies) {movie in
                    MovieView(movie: movie, screenSize: screenSize, width: itemWidth)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
