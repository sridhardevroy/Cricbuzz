//
//  MoviesViewModel.swift
//  CricBuzzAssignment
//
//  Created by Sreedhar Adapala on 30/09/23.
//

import Foundation

class LocalDataManager {
    static func parseLocalJSONDataFrom(_ fileName: String, extensionType: String, completion: @escaping ([Movie]?) -> Void) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: extensionType) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let movies = try decoder.decode([Movie].self, from: data)
                completion(movies)
            } catch {
                print("Error parsing local JSON: \(error)")
                completion(nil)
            }
        } else {
            completion(nil)
        }
    }
}


class MovieViewModel {
    var movies: [Movie] = []
    var movieSectionsData: [[String]] = []
    var filteredMovies: [Movie] = []
    
    func getTitleForCellWith(_ indexpath: IndexPath) -> String {
        return movieSectionsData[indexpath.section][indexpath.row]
    }
    
    func filterMoviesListWith(_ searchText: String) {
        filteredMovies = movies.filter { movie in
            return movie.title.lowercased().contains(searchText.lowercased()) ||
                   movie.actors.lowercased().contains(searchText.lowercased()) ||
                   movie.director.lowercased().contains(searchText.lowercased()) ||
                   movie.genre.lowercased().contains(searchText.lowercased()) ||
                   movie.year.lowercased().contains(searchText.lowercased())
        }
          
    }
    
    func getMoviesListWith(_ searchText: String, for category: MovieSection) -> [Movie] {
        switch category {
        case .actors:
            return movies.filter { movie in
                return movie.actors.lowercased().contains(searchText.lowercased())
            }
        case .directors:
            return movies.filter { movie in
                return movie.director.lowercased().contains(searchText.lowercased())
            }
        case .genre:
            return movies.filter { movie in
                return movie.genre.lowercased().contains(searchText.lowercased())
            }
        case .year:
            return movies.filter { movie in
                return movie.year.lowercased().contains(searchText.lowercased())
            }
            
        case .allMovies:
            return movies
        }
    }
    
    private func mapMoviesDataToAllTheRequiredFilters() {
        let years = Array(Set(self.movies.map { movie in
            movie.year
        }))
        let genres = Array(Set(self.movies.flatMap { movie in
            movie.genre.components(separatedBy: ",")
        }))
        let directors = Array(Set(self.movies.flatMap { movie in
            movie.director.components(separatedBy: ",")
        }))
        let actors = Array(Set(self.movies.flatMap { movie in
            movie.actors.components(separatedBy: ",")
        }))
        
        movieSectionsData.append(years)
        movieSectionsData.append(genres)
        movieSectionsData.append(directors)
        movieSectionsData.append(actors)
    }

    func fetchLocalMovies(completion: @escaping (Error?) -> Void) {
        LocalDataManager.parseLocalJSONDataFrom("movies", extensionType: "json") { [weak self] movies in
            if let movies = movies {
                self?.movies = movies
                self?.mapMoviesDataToAllTheRequiredFilters()
                completion(nil)
            } else {
                let error = NSError(domain: "YourAppErrorDomain", code: 1, userInfo: nil)
                completion(error)
            }
            self?.resetFilteredMovies()
        }
    }
    
    func resetFilteredMovies() {
        self.filteredMovies = movies
    }
}


