//
//  ViewControllerTests.swift
//  CricBuzzAssignmentTests
//
//  Created by Sreedhar Adapala on 03/10/23.
//

import XCTest
@testable import CricBuzzAssignment

class ViewControllerTests: XCTestCase {
    
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        
        // Create an instance of the ViewController from the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        viewController.loadViewIfNeeded() // Load the view hierarchy
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    // MARK: - View Load and Initialization Tests
    
    func testViewControllerNotNil() {
        XCTAssertNotNil(viewController, "ViewController is not initialized")
    }
    
    func testTableViewIsConnected() {
        XCTAssertNotNil(viewController.tableView, "TableView outlet is not connected")
    }
    
    func testViewModelIsInitialized() {
        XCTAssertNotNil(viewController.viewModel, "ViewModel is not initialized")
    }
    
    // MARK: - Table View Tests
    
    func testTableViewDataSource() {
        // Ensure that the data source methods return the expected number of sections and rows
        XCTAssertNotEqual(viewController.numberOfSections(in: viewController.tableView), 0, "Number of sections is incorrect")
        XCTAssertNotEqual(viewController.tableView(viewController.tableView, numberOfRowsInSection: 0), 0, "Number of rows in section 0 is incorrect")
    }
    
    func testTableViewCellForIndexPath() {
        // Test the creation of a cell for a given index path
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath)
        XCTAssertNotNil(cell, "Table view cell is not created")
        // You can add more specific assertions related to cell configuration if needed
    }
    
    // Add more table view tests for delegate methods, cell selection, and section header/footer as needed
    
    // MARK: - Search Bar Tests

    
    // Add more tests for search functionality, including filtered data and search result display
    
    // MARK: - Navigation Tests
    
    func testNavigationToMovieDetails() {
        // Simulate tapping a table view cell to navigate to movie details
        let indexPath = IndexPath(row: 0, section: 0)
        viewController.tableView(viewController.tableView, didSelectRowAt: indexPath)
        
        // Ensure that the navigation stack contains the expected view controller
        XCTAssertFalse(viewController.navigationController?.topViewController is MovieDetailsViewController, "Did not navigate to MovieDetailsViewController")
    }
    
    // Add more navigation tests for other view controllers as needed
    
    // MARK: - Custom Functionality Tests
    
    // Add tests for any custom methods or functionality implemented in your ViewController
    
    // Example:
    // func testCustomFunctionality() { ... }
}

