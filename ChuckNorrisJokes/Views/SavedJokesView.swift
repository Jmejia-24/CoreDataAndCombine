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
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \JokeManagedObject.value,
                                                     ascending: true)], animation: .default)
    private var jokes: FetchedResults<JokeManagedObject>

    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(jokes, id: \.self) { joke in
                        Text(joke.value ?? "N/A")
                    }
                    .onDelete { indices in
                        jokes.delete(at: indices, inViewContext: viewContext)
                    }
                }
                .navigationBarTitle("Saved Jokes")
            }
        }
    }
}

struct SavedJokesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedJokesView()
    }
}
