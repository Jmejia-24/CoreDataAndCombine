//
//  JokeCardView.swift
//  ChuckNorrisJokes
//
//  Created by User on 9/23/22.
//  Copyright © 2022 Byron Mejia. All rights reserved.
//

import SwiftUI
import ChuckNorrisJokesModel

struct JokeCardView: View {
    private var bounds: CGRect { UIScreen.main.bounds }
    
    private var repeatingAnimation: Animation {
        Animation.linear(duration: 1)
            .repeatForever()
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 20) {
                Text(ChuckNorrisJokesModel.Joke.starter.value)
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                    .minimumScaleFactor(0.2)
                    .allowsTightening(true)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .animation(.easeInOut)
            }
            .frame(width: min(300, bounds.width * 0.7), height: min(400, bounds.height * 0.6))
            .padding(20)
            .cornerRadius(20)
        }
    }
}

#if DEBUG
struct JokeCardView_Previews: PreviewProvider {
    static var previews: some View {
        JokeCardView()
            .previewLayout(.sizeThatFits)
    }
}
#endif
