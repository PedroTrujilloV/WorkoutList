//
//  WorkoutListAppTests.swift
//  WorkoutListAppTests
//
//  Created by Pedro Enrique Trujillo Vargas on 7/9/21.
//

import XCTest
@testable import WorkoutListApp

class WorkoutListAppTests: XCTestCase, DataSourceDelegate {


    var givenDataSource: DataSource?
    var dataSourceValue: Array<ExerciseViewModel>?
    var asyncExpectationTest1: XCTestExpectation?
    var asyncExpectationTest2: XCTestExpectation?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test1DataSourceInitialization() {
        test1DataSourceInitialization(completion: nil)
    }
    
    func test1DataSourceInitialization(completion: (() -> Void )? )  {
        let givenNext = "https://wger.de/api/v2/exercise/?format=json&language=2&limit=20&offset=20"
        let givenExpectation1 = expectation(description: " test2DataSourceNext expectation1")
        
        //when
        self.asyncExpectationTest1 = givenExpectation1
        self.givenDataSource = DataSource(delegate: self)

        self.waitForExpectations(timeout: 10) { error in
            if let error = error {
              XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            guard let next = self.givenDataSource?.currentResult?.next else {print("\ntest1DataSourceInitialization: No next url in result\n"); return}

            //then
            XCTAssertTrue(next == givenNext)
            
            guard let completion = completion else {return}
            completion()
        }
    }
    
    
    func test2DataSourceNext()  {
        //given
        let givenNext = "https://wger.de/api/v2/exercise/?format=json&language=2&limit=20&offset=40"
        
        //when
        test1DataSourceInitialization {
            let givenExpectation2 = self.expectation(description: " test2DataSourceNext expectation2")
            self.asyncExpectationTest2 = givenExpectation2
            self.givenDataSource?.loadNext()
            self.waitForExpectations(timeout: 10) { error in
              if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
              }
                guard let next = self.givenDataSource?.currentResult?.next else {print("\ntest2DataSourceNext: No next url in result\n"); return}
                
                //then
                XCTAssertTrue(next == givenNext)
            }
        }
    }
    
    // Conforming DataSourceDelegate
    func dataSourceDidLoad(dataSource:Array<ExerciseViewModel>) {
        print("\n\n > WorkoutListAppTests dataSourceDidLoad count: \(dataSource.count)\n\n")
        
        if let expectation = asyncExpectationTest1 {
              //XCTFail("delegate was not setup correctly. Missing XCTExpectation reference")
            expectation.fulfill()
            asyncExpectationTest1 = nil
        } else { print("asyncExpectationTest1 Delegate was not setup correctly, or is not being tested. Missing XCTExpectation reference\n")}
        
        if let expectation = asyncExpectationTest2 {
            expectation.fulfill()
            asyncExpectationTest2 = nil
        } else { print("asyncExpectationTest2 Delegate was not setup correctly, or is not being tested. Missing XCTExpectation reference\n")}
    
        self.dataSourceValue = dataSource
    }
    
    func test3DataSourceRetrieveImageModel(){
        let givenImageStringURL = "/media/exercise-images/177/Seated-leg-curl-1.png.80x80_q85.jpg"
        let givenId = 167
        let givenExpectation = expectation(description: "test3DataSourceRetrieveImageModel expectation")
        //when
        DataSource.retrieveImageModel(with: givenId) { imageModel in
            let thumbnail = imageModel?.thumbnail.url
            
            //then
            XCTAssertTrue(givenImageStringURL == thumbnail)
            givenExpectation.fulfill()
        }
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func test4DataSourceRetrieveCategories(){
        let givenId = 14
        let givencCategoryName = "Calves"
        let givenExpectation = expectation(description: "test4DataSourceRetrieveCategories expectation")
        
        //when
        DataSource.retrieveCategory(by: givenId) { categoryName in
            //then
            XCTAssertTrue(givencCategoryName == categoryName)
            givenExpectation.fulfill()
        }
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func test5DataSourceRetrieveEquipment(){
        let givenId = 8
        let givenEquipmentName = "Bench"
        let givenExpectation = expectation(description: "test5DataSourceRetrieveEquipment expectation")
        
        //when
        DataSource.retrieveEquipment(by: givenId) { equipmentName in
            //then
            XCTAssertTrue(givenEquipmentName == equipmentName)
            givenExpectation.fulfill()
        }
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }


}
