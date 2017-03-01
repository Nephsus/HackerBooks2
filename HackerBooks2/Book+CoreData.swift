//
//  Book+CoreDate.swift
//  HackerBooks2
//
//  Created by David Cava Jimenez on 22/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import CoreData



extension Book: ManagedObjectType{

    public static var entityName:String { get { return "Book" } }
    
    
    class func fetchRequestOrderedByName() -> NSFetchRequest<Book> {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        return fetchRequest
    }


    class func fetchRequestFavorites() -> NSFetchRequest<Book> {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = NSPredicate(format: " favorito == YES")

        return fetchRequest
    }
    
    
    class func fetchRequestFilter(searchText: String ) -> NSFetchRequest<Book> {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
       // fetchRequest.predicate = NSPredicate(format: " title CONTAINS[cd]  %@ OR Tag.title CONTAINS[cd] %@", searchText, searchText)
        fetchRequest.predicate = NSPredicate(format: "ANY tags.title CONTAINS[cd] %@", searchText)
        fetchRequest.returnsDistinctResults = true
        
        return fetchRequest
    }


    
   
}
