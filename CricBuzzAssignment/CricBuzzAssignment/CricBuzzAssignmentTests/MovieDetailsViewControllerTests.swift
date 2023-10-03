//
//  MovieDetailsViewControllerTests.swift
//  CricBuzzAssignmentTests
//
//  Created by Sreedhar Adapala on 03/10/23.
//

import XCTest
@testable import CricBuzzAssignment

class MovieDetailsViewControllerTests: XCTestCase {

    var movieDetailsViewController: MovieDetailsViewController!

    override func setUp() {
        super.setUp()
        // Create a sample movie
        let movie = Movie.init(title: "Test", year: "Test", rated: "Test", released: "Test", runtime: "Test", genre: "Test", director: "Test", writer: "Test", actors: "Test", plot: "Test", language: "Test", country: "Test", awards: "Test", poster: "Test", ratings: [Rating(source: "Test", value: "67%")], metascore: "Test", imdbRating: "Test", imdbVotes: "Test", imdbID: "Test", type: "Test", dvd: "Test", boxOffice: "Test", production: "Test", website: "Test", response: "Test")
        movieDetailsViewController = MovieDetailsViewController(movie: movie)
        movieDetailsViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        movieDetailsViewController = nil
        super.tearDown()
    }

    // MARK: - View Hierarchy Tests

    func testViewHierarchy() {
        // Assert that key subviews are added to the view hierarchy
        XCTAssertNotNil(movieDetailsViewController.scrollView)
        XCTAssertNotNil(movieDetailsViewController.contentView)
        XCTAssertNotNil(movieDetailsViewController.imageView)
        XCTAssertNotNil(movieDetailsViewController.titleLabel)
        XCTAssertNotNil(movieDetailsViewController.overviewLabel)
        XCTAssertNotNil(movieDetailsViewController.castAndCrewLabel)
        XCTAssertNotNil(movieDetailsViewController.releasedDateLabel)
        XCTAssertNotNil(movieDetailsViewController.genreLabel)
        XCTAssertNotNil(movieDetailsViewController.ratingSegmentControl)
    }

    // MARK: - Label Configuration Tests

    func testLabelConfiguration() {
        // Assert that labels are correctly configured with movie data
        XCTAssertEqual(movieDetailsViewController.titleLabel.text, "Title: \n Test")
        XCTAssertEqual(movieDetailsViewController.overviewLabel.text, "Plot: \n Test")
        XCTAssertEqual(movieDetailsViewController.castAndCrewLabel.text, "Cast & Crew: \n Test")
        XCTAssertEqual(movieDetailsViewController.releasedDateLabel.text, "Released Date: Test")
        XCTAssertEqual(movieDetailsViewController.genreLabel.text, "Genre: Test")
    }

    // MARK: - Segmented Control Tests

    func testRatingSegmentControl() {
        // Assert that the segmented control is correctly set up with ratings
        XCTAssertEqual(movieDetailsViewController.ratingSegmentControl.numberOfSegments, 1)
        movieDetailsViewController.setUpRatingSegmentControl()
        XCTAssertEqual(movieDetailsViewController.ratingSegmentControl.numberOfSegments, 2) // Modify this to match the actual number of ratings
    }

}

