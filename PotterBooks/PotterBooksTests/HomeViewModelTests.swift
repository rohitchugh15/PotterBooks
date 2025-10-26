//
//  HomeViewModelTests.swift
//  PotterBooksTests
//
//  Created by Rohit Chugh on 27/10/25.
//

import XCTest
@testable import PotterBooks

@MainActor
final class HomeViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchAllBooks_Success() async {
        // Arrange
        let vm = HomeViewModel(booksRepository: MockBooksRepository())
        
        // Act
        vm.testable_fetchAllBooks()
        
        // Wait for Task to finish
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1.0s for Task
        
        //Assert
        XCTAssertEqual(vm.booksDataSource.count, 2)
        XCTAssertEqual(vm.state, .loaded)
        XCTAssertEqual(vm.booksDataSource.first?.title, "Harry Potter and the Sorcerer's Stone")
    }
    
    func testFetchAllBooks_Error() async {
        // Arrange
        let vm = HomeViewModel(booksRepository: MockBooksRepository(responseType: .error))
        
        // Act
        vm.testable_fetchAllBooks()
        
        // Wait for Task to finish
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1.0s for Task
        
        //Assert
        XCTAssert(vm.booksDataSource.isEmpty)
        XCTAssertEqual(vm.state, .error("The operation couldn’t be completed. (PotterBooks.NetworkError error 3.)"))
    }
    
    func testFetchAllBooks_Faliure() async {
        // Arrange
        let vm = HomeViewModel(booksRepository: MockBooksRepository(responseType: .offline))
        
        // Act
        vm.testable_fetchAllBooks()
        
        // Wait for Task to finish
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1.0s for Task
        
        //Assert
        XCTAssert(vm.booksDataSource.isEmpty)
        XCTAssertEqual(vm.state, .offline)
    }
}
