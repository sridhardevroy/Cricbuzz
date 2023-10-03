//
//  MoviesViewModelTests.swift
//  CricBuzzAssignmentTests
//
//  Created by Sreedhar Adapala on 03/10/23.
//

import XCTest
@testable import CricBuzzAssignment

class MovieViewModelTests: XCTestCase {

    var movieViewModel: MovieViewModel!

    override func setUp() {
        super.setUp()
        movieViewModel = MovieViewModel()
    }

    override func tearDown() {
        movieViewModel = nil
        super.tearDown()
    }

    // MARK: - Data Loading and Initialization Tests

    func testFetchLocalMoviesSuccess() {
        // Arrange
        let expectation = self.expectation(description: "Fetch movies successfully")
        
        // Act
        movieViewModel.fetchLocalMovies { [weak self] error in
            // Assert
            XCTAssertNil(error, "Fetching local movies should not result in an error")
            XCTAssertEqual(self?.movieViewModel.movies.count, 19, "Expected 19 movies to be loaded")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    

    // MARK: - Filtering Tests

    func testFilterMoviesList() {
        // Arrange
        let searchText = "Meet The Parents"
        
        // Act
        movieViewModel.filterMoviesListWith(searchText)
        
        // Assert
        
        XCTAssertTrue(movieViewModel.filteredMovies.allSatisfy { movie in
            return movie.title.lowercased().contains(searchText.lowercased()) ||
                   movie.actors.lowercased().contains(searchText.lowercased()) ||
                   movie.director.lowercased().contains(searchText.lowercased()) ||
                   movie.genre.lowercased().contains(searchText.lowercased()) ||
                   movie.year.lowercased().contains(searchText.lowercased())
        }, "Filtered movies should match the search criteria")
    }

    func testResetFilteredMovies() {
        // Arrange
        let searchText = "Action"
        movieViewModel.filterMoviesListWith(searchText)
        
        // Act
        movieViewModel.resetFilteredMovies()
        
        // Assert
        XCTAssertEqual(movieViewModel.filteredMovies.count, movieViewModel.movies.count, "Filtered movies should be reset to all movies")
    }

    // MARK: - Helper Method Tests

    func testGetMoviesListWithGenre() {
        // Arrange
        let searchText = "Fantasy"
        
        // Act
        let filteredMovies = movieViewModel.getMoviesListWith(searchText, for: .genre)
        
        // Assert
        XCTAssertTrue(filteredMovies.allSatisfy { movie in
            return movie.genre.lowercased().contains(searchText.lowercased())
        }, "Filtered movies by genre should match the search criteria")
    }

    // Add more tests for other helper methods like getMoviesListWith, mapMoviesDataToAllTheRequiredFilters, and getTitleForCellWith.
}

