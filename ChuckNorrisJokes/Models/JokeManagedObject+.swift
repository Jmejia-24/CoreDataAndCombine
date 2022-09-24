//
//  JokeManagedObject+.swift
//  ChuckNorrisJokes
//
//  Created by User on 9/24/22.
//  Copyright © 2022 Byron Mejia. All rights reserved.
//

import SwiftUI
import CoreData
import ChuckNorrisJokesModel

extension JokeManagedObject {
    static func save(joke: Joke, inViewContext viewContext: NSManagedObjectContext) {
        guard joke.id != "error" else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: JokeManagedObject.self))
        fetchRequest.predicate = NSPredicate(format: "id = %@", joke.id)
        
        if let results = try? viewContext.fetch(fetchRequest),
           let existing = results.first as? JokeManagedObject {
            existing.value = joke.value
            existing.categories = joke.categories as NSArray
        } else {
            let newJoke = self.init(context: viewContext)
            newJoke.id = joke.id
            newJoke.value = joke.value
            newJoke.categories = joke.categories as NSArray
        }
        
        do {
            try viewContext.save()
        } catch {
            fatalError("\(#file), \(#function), \(error.localizedDescription)")
        }
    }
}

extension Collection where Element == JokeManagedObject, Index == Int {
    func delete(at indices: IndexSet, inViewContext viewContext: NSManagedObjectContext) {
        indices.forEach { index in
            viewContext.delete(self[index])
        }
        
        do {
            try viewContext.save()
        } catch {
            fatalError("\(#file), \(#function), \(error.localizedDescription)")
        }
    }
}
