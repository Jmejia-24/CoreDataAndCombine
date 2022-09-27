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
    private lazy var testJoke = testJoke(forResource: "TestJoke")
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
    
    private func mockJokesService(withError: Bool = false) ->  MockJokesService {
        MockJokesService(data: testJoke.data, error: withError ? error : nil)
    }
    
    private func viewModel(withJokeError jokeError: Bool = false) -> JokesViewModel {
        JokesViewModel(jokesService: mockJokesService(withError: jokeError))
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
        let viewModel = self.viewModel()
        let translationPercent = 0.5
        let expected = Color("Green")
        var result: Color = .clear
        
        viewModel.$backgroundColor
            .sink {
                result = $0
            }
            .store(in: &subscriptions)
        
        viewModel.updateBackgroundColorForTranslation(translationPercent)
        XCTAssert(result == expected, "Color expected to be \(expected) but was \(result)")
    }
    
    func test_decisionStateFor60TranslationPercentIsLiked() {
        let viewModel = self.viewModel()
        let translationPercent = 0.6
        let bounds = CGRect(x: 0, y: 0, width: 414, height: 896)
        let x = bounds.width
        let expected: JokesViewModel.DecisionState = .liked
        var result: JokesViewModel.DecisionState = .undecided
        
        viewModel.$decisionState
            .sink {
                result = $0
            }
            .store(in: &subscriptions)
        
        viewModel.updateDecisionStateForTranslation(translationPercent, andPredictedEndLocationX: x, inBounds: bounds)
        XCTAssert(result == expected, "Decision state expected to be \(expected) but was \(result)")
    }
    
    func test_decisionStateFor59TranslationPercentIsUndecided() {
        let viewModel = self.viewModel()
        let translationPercent = 0.59
        let bounds = CGRect(x: 0, y: 0, width: 414, height: 896)
        let x = bounds.width
        let expected: JokesViewModel.DecisionState = .undecided
        var result: JokesViewModel.DecisionState = .disliked
        
        viewModel.updateDecisionStateForTranslation(translationPercent, andPredictedEndLocationX: x, inBounds: bounds)
        
        viewModel.$decisionState
            .sink {
                result = $0
            }
            .store(in: &subscriptions)
        
        XCTAssert(result == expected, "Decision state expected to be \(expected) but was \(result)")
    }
    
    func test_fetchJokeSucceeds() {
        let viewModel = self.viewModel()
        let expectation = self.expectation(description: #function)
        let expected = self.testJoke.value
        var result: Joke!
        
        viewModel.$joke
            .dropFirst()
            .sink {
                result = $0
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        viewModel.fetchJoke()
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssert(result == expected, "Joke expected to be \(expected) but was \(String(describing: result))")
    }
    
    func test_fetchJokeReceivesErrorJoke() {
        let viewModel = self.viewModel(withJokeError: true)
        let expectation = self.expectation(description: #function)
        let expected = Joke.error
        var result: Joke!
        
        viewModel.$joke
            .dropFirst()
            .sink {
                result = $0
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        viewModel.fetchJoke()
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssert(result == expected, "Joke expected to be \(expected) but was \(String(describing: result))")
    }
}
