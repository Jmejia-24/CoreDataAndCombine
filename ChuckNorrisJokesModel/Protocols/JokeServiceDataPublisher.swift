//
//  JokeServiceDataPublisher.swift
//  ChuckNorrisJokes
//
//  Created by User on 9/23/22.
//  Copyright © 2022 Byron Mejia. All rights reserved.
//

import Combine

public protocol JokeServiceDataPublisher {
    func publisher() -> AnyPublisher<Data, URLError>
}
