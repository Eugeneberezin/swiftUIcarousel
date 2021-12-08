//
//  ViewModel.swift
//  SwiftUIcarousel
//
//  Created by Eugene Berezin on 11/16/21.
//

import SwiftUI

enum LoadStatus {
    case ready (nextPage: Int)
    case loading (page: Int)
    case error
    case done
}

class ViewModel: ObservableObject, RandomAccessCollection {
    @Published var movies: [Result] = []
    @Published var isTabBarDisplayed = true
    
    typealias Element = Result
    
    subscript(position: Int) -> Result {
        return movies[position]
    }
    
    var startIndex: Int {movies.startIndex}
    var endIndex: Int {movies.endIndex}
    var loadingStatus = LoadStatus.ready(nextPage: 1)
    
    init() {}
    
    func shouldLoadMoreData(currentItem: Result? = nil) -> Bool {
        guard let currentItem = currentItem else {
            return true
        }
        
        for n in (movies.count - 3)...(movies.count - 1) {
            if currentItem.id == movies[n].id {
                return true
            }
        }
        return false
    }
    
    func loadMoreMovies(searchTern: String, currentItem: Result? = nil) {
        if !shouldLoadMoreData(currentItem: currentItem) {
            return
        }
        
        guard case let .ready(page) = loadingStatus else {
            return
        }
        
        loadingStatus = .loading(page: page)
        
        print(page)
        
        Service.shared.fetchMovies(searchTerm: searchTern, page: page) { results, error in
            
        }
        
    }
    
    func getMovies(searchTerm: String) {
        Service.shared.fetchMovies(searchTerm: searchTerm) { movies, _ in
            DispatchQueue.main.async {
                self.movies = movies
            }
        }
    }
}
