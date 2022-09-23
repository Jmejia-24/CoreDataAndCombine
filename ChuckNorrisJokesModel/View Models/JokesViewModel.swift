//
//  JokesViewModel.swift
//  ChuckNorrisJokes
//
//  Created by User on 9/23/22.
//  Copyright © 2022 Byron Mejia. All rights reserved.
//

import SwiftUI

public final class JokesViewModel {
    public enum DecisionState {
        case disliked, undecided, liked
    }
    
    private static let decoder = JSONDecoder()
    
    public init(jokesService: JokeServiceDataPublisher? = nil) {
        
    }
    
    public func fetchJoke() {
        
    }
    
    public func updateBackgroundColorForTranslation(_ translation: Double) {
        
    }
    
    public func updateDecisionStateForTranslation(
        _ translation: Double,
        andPredictedEndLocationX x: CGFloat,
        inBounds bounds: CGRect) {
            
        }
    
    public func reset() {
        
    }
}
