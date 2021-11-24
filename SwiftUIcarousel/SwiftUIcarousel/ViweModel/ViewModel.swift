//
//  ViewModel.swift
//  SwiftUIcarousel
//
//  Created by Eugene Berezin on 11/16/21.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var movies: [Result] = []
    @Published var isTabBarDisplayed = true
    
    init() {}
    
    func getMovies(searchTerm: String) {
        Service.shared.fetchMovies(searchTerm: searchTerm) { movies, _ in
            DispatchQueue.main.async {
                self.movies = movies
            }
        }
    }
}
