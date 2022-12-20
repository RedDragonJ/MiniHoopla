//
//  TestMoviesProcessor.swift
//  MiniHooplaTests
//
//  Created by James Layton on 12/20/22.
//

import XCTest

final class TestMoviesProcessor: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetMovies_WithURL_ReturnError() async {
        // Arrange
        let mockNetworkSession = MockNetworkSession()
        let moviewProcessor = MoviesProcessor(networkSession: mockNetworkSession)
        let url = URL(string: "ErrorTest")
        
        var testError: Error?
        
        // Act
        do {
            try await moviewProcessor.getMovies(url!)
        } catch let error {
            testError = error
        }
        
        // Assert
        XCTAssertNotNil(testError)
    }

    func testGetMovies_WithURL_ReturnMovieData() async {
        // Arrange
        let mockNetworkSession = MockNetworkSession()
        let moviewProcessor = MoviesProcessor(networkSession: mockNetworkSession)
        let url = URL(string: "TestMovie")
        
        var testError: Error?
        var testResult: [Movie]?
        
        // Act
        do {
            try await moviewProcessor.getMovies(url!)
            testResult = moviewProcessor.movies
        } catch let error {
            testError = error
        }
        
        // Assert
        XCTAssertNil(testError)
        XCTAssertEqual(testResult![0].title, "TestTitle")
    }
    
    func testGetMovieDetails_WithURL_ReturnMovieDetailData() async {
        // Arrange
        let mockNetworkSession = MockNetworkSession()
        let moviewProcessor = MoviesProcessor(networkSession: mockNetworkSession)
        let url = URL(string: "TestMovieDetail")
        
        var testError: Error?
        var testResult: MovieDetail?
        
        // Act
        do {
            testResult = try await moviewProcessor.getMovieDetails(url!)
        } catch let error {
            testError = error
        }
        
        // Assert
        XCTAssertNil(testError)
        XCTAssertEqual(testResult?.id, 123)
    }
}
