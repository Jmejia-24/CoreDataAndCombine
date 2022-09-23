//
//  JokesViewModelTests.swift
//  ChuckNorrisJokes
//
//  Created by User on 9/23/22.
//  Copyright © 2022 Byron Mejia. All rights reserved.
//

import XCTest
import Combine
import SwiftUI
@testable import ChuckNorrisJokesModel

final class JokesViewModelTests: XCTestCase {
    private lazy var testJoke = self.testJoke(forResource: "TestJoke")
    private lazy var testTranslatedJokeValue = self.testJoke(forResource: "TestTranslatedJoke").value.value
    private lazy var error = URLError(.badServerResponse)
    private var subscriptions = Set<AnyCancellable>()
    
    override func tearDown() {
        subscriptions = []
    }
    
    private func testJoke(forResource resource: String) -> (data: Data, value: Joke) {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: resource, withExtension: "json"),
              let  data = try? Data(contentsOf: url),
              let joke = try? JSONDecoder().decode(Joke.self, from: data)
        else { fatalError("Failed to load \(resource)") }
        
        return (data, joke)
    }
    
    
    
    func test_createJokesWithSampleJokeData() {
        guard let url = Bundle.main.url(forResource: "SampleJoke", withExtension: "json"),
              let data = try? Data(contentsOf: url)
        else { return XCTFail("SampleJoke file missing or data is corrupted") }
        
        let sampleJoke: Joke
        
        do {
            sampleJoke = try JSONDecoder().decode(Joke.self, from: data)
        } catch {
            return XCTFail(error.localizedDescription)
        }
        
        XCTAssert(sampleJoke.categories.count == 1, "Sample joke categories.count was expected to be 1 but was \(sampleJoke.categories.count)")
        XCTAssert(sampleJoke.value == "Chuck Norris writes code that optimizes itself.", "First sample joke was expected to be \"Chuck Norris writes code that optimizes itself.\" but was \"\(sampleJoke.value)\"")
    }
    
    func test_backgroundColorFor50TranslationPercentIsGreen() {

    }
    
    func test_decisionStateFor60TranslationPercentIsLiked() {

    }
    
    func test_decisionStateFor59TranslationPercentIsUndecided() {
        
    }
    
    func test_fetchJokeSucceeds() {

    }
    
    func test_fetchJokeReceivesErrorJoke() {
        
    }
}
