import Foundation

class Service {
    
    static let shared = Service() // singleton
    
    func fetchMovies(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
        print("Fetching movies!")
        
        let API_KEY = "876db37c9eb2be92a162285d2d985373"
        
        let urlString = "https://api.themoviedb.org/3/search/movie?query=\(searchTerm)&page=1&api_key=\(API_KEY)"
        guard let url = URL(string: urlString) else { return }
        
        // fetch data from internet
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print("Failed to fetch apps:", err)
                completion([], nil)
                return
            }
            
            // success
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let searchResult = try decoder.decode(SearchResult.self, from: data)
                
                completion(searchResult.results ?? [], nil)
            
                
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
                completion([], jsonErr)
            }
            
            }.resume() // fires off the request
    }
    
}


