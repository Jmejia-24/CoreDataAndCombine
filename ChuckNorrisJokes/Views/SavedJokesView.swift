//
//  SavedJokesView.swift
//  ChuckNorrisJokes
//
//  Created by User on 9/23/22.
//  Copyright © 2022 Byron Mejia. All rights reserved.
//

import SwiftUI
import ChuckNorrisJokesModel

struct SavedJokesView: View {
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(jokes, id: \.self) { joke in
                        Text(joke)
                    }
                    .onDelete { indices in
                        
                    }
                }
                .navigationBarTitle("Saved Jokes")
            }
        }
    }
    
    private var jokes = [String]()
}

struct SavedJokesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedJokesView()
    }
}
