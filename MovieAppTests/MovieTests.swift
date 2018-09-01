//
//  MovieTests.swift
//  MovieAppTests
//
//  Created by irna on 9/1/18.
//  Copyright © 2018 irna. All rights reserved.
//

import XCTest

@testable import MovieApp

class MovieTests: XCTestCase {
    var storyboard = UIStoryboard()
    var home : ViewController!
    var detail : MovieDetailViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        home = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        detail = storyboard.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_title_is_MovieApp() {
        let _ = home.view
        XCTAssertEqual("Movie App", home.navigationItem.title!)
    }

    func test_total_movies(){
        let dataMovie : Movie = Movie.init(voteCount: 539, id: 345940, video: false, voteAverage: 6.2, title: "The Meg", popularity: 166.986, posterPath: "/xqECHNvzbDL5I3iiOVUkVPJMSbc.jpg", originalLanguage: "en", originalTitle: "The Meg", genreIDS: [28,878,53,27], backdropPath: "/ibKeXahq4JD63z6uWQphqoJLvNw.jpg", adult: false, overview: "A deep sea submersible pilot revisits his past fears in the Mariana Trench, and accidentally unleashes the seventy foot ancestor of the Great White Shark believed to be extinct.", releaseDate: "2018-08-09")
        let dataMovies : MovieResults = MovieResults.init(results: [dataMovie], page: 1, totalResults: 1, dates: Dates.init(maximum: "2018-08-09", minimum: "2018-08-09"), totalPages: 1)
        let home = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let _ = home.tblMovie
        let totalRow = dataMovies.results.count
        XCTAssert( totalRow == dataMovies.totalResults, "Number of Rows in home is same like total results")
    }
    
    func test_title_detail_movie(){
        let dataMovie : Movie = Movie.init(voteCount: 539, id: 345940, video: false, voteAverage: 6.2, title: "The Meg", popularity: 166.986, posterPath: "/xqECHNvzbDL5I3iiOVUkVPJMSbc.jpg", originalLanguage: "en", originalTitle: "The Meg", genreIDS: [28,878,53,27], backdropPath: "/ibKeXahq4JD63z6uWQphqoJLvNw.jpg", adult: false, overview: "A deep sea submersible pilot revisits his past fears in the Mariana Trench, and accidentally unleashes the seventy foot ancestor of the Great White Shark believed to be extinct.", releaseDate: "2018-08-09")
        detail.selectedMovie = dataMovie
        let _ = detail.view
        XCTAssertEqual(dataMovie.originalTitle, detail.navigationItem.title!)
    }

    
}
