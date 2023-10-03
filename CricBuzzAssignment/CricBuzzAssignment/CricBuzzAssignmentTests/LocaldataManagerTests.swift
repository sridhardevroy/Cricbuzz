//
//  LocaldataManagerTests.swift
//  CricBuzzAssignmentTests
//
//  Created by Sreedhar Adapala on 03/10/23.
//

import XCTest

class LocalDataManagerTests: XCTestCase {

    // MARK: - Success Case Tests

    func testParseLocalJSONDataSuccess() {
        // Arrange
        let fileName = "movies"
        let extensionType = "json"
        
        // Act
        var resultMovies: [Movie]?
        LocalDataManager.parseLocalJSONDataFrom(fileName, extensionType: extensionType) { movies in
            resultMovies = movies
        }
        
        // Assert
        XCTAssertNotNil(resultMovies, "Movies should not be nil")
        XCTAssertEqual(resultMovies?.count, 19, "Expected 2 movies")
        
        // You can add more specific assertions based on the JSON content.
    }

    // MARK: - Failure Case Tests

    func testParseLocalJSONDataFailure() {
        // Arrange
        let fileName = "non_existent_file"
        let extensionType = "json"
        
        let mockBundle = MockBundle()
        mockBundle.mockURL = nil // Simulate a missing file
        
        
        // Act
        var resultMovies: [Movie]?
        LocalDataManager.parseLocalJSONDataFrom(fileName, extensionType: extensionType) { movies in
            resultMovies = movies
        }
        
        // Assert
        XCTAssertNil(resultMovies, "Movies should be nil due to failure")
    }
}

// MockBundle for simulating bundle behavior
class MockBundle: Bundle {
    var mockURL: URL?
    var mockData: Data?
    
    override func url(forResource name: String?, withExtension ext: String?) -> URL? {
        return mockURL
    }
    
    override func url(forResource name: String?, withExtension ext: String?, subdirectory subpath: String?) -> URL? {
        return mockURL
    }
    
     func data(forResource name: String?, withExtension ext: String?) throws -> Data {
        guard let data = mockData else {
            throw NSError(domain: "Test", code: 404, userInfo: nil)
        }
        return data
    }
}
