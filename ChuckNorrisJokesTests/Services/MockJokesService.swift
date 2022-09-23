//
//  MockJokesService.swift
//  ChuckNorrisJokes
//
//  Created by User on 9/23/22.
//  Copyright © 2022 Byron Mejia. All rights reserved.
//

import Combine
@testable import ChuckNorrisJokesModel

struct MockJokesService: JokeServiceDataPublisher {
    let data: Data
    let error: URLError?
    
    init(data: Data, error: URLError? = nil) {
        self.data = data
        self.error = error
    }
}
