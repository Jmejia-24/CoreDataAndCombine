//
//  JokesService.swift
//  ChuckNorrisJokes
//
//  Created by User on 9/23/22.
//  Copyright © 2022 Byron Mejia. All rights reserved.
//

import Combine

public struct JokesService {
    private var url: URL {
        urlComponents.url!
    }
    
    private var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.chucknorris.io"
        components.path = "/jokes/random"
        components.setQueryItems(with: ["category": "dev"])
        return components
    }
    
    public init() { }
}

extension JokesService: JokeServiceDataPublisher {
    public func publisher() -> AnyPublisher<Data, URLError> {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
