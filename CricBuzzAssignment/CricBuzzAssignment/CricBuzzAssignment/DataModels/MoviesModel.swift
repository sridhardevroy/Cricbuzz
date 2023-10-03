//
//  MoviesModel.swift
//  CricBuzzAssignment
//
//  Created by Sreedhar Adapala on 30/09/23.
//

import Foundation

import Foundation

enum MovieSection: Int, CaseIterable {
    case year
    case genre
    case directors
    case actors
    case allMovies
    
    var sectionIndex: Int {
        return self.rawValue
    }
    
    var rawSectionValue: String {
        switch self {
        case .year:
            return "Year"
        case .genre:
            return "Genre"
        case .directors:
            return "Directors"
        case .actors:
            return "Actors"
        case .allMovies:
            return "All Movies"
        }
    }
}

struct Movie: Codable {
    let title: String
    let year: String
    let rated: String
    let released: String
    let runtime: String
    let genre: String
    let director: String
    let writer: String
    let actors: String
    let plot: String
    let language: String
    let country: String
    let awards: String?
    let poster: String?
    let ratings: [Rating]
    let metascore: String?
    let imdbRating: String
    let imdbVotes: String
    let imdbID: String
    let type: String
    let dvd: String?
    let boxOffice: String?
    let production: String?
    let website: String?
    let response: String
    
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case response = "Response"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating = "imdbRating"
        case imdbVotes = "imdbVotes"
        case imdbID = "imdbID"
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
    }
}

struct Rating: Codable {
    let source: String
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
