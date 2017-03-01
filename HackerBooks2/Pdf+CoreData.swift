//
//  Pdf.swift
//  HackerBooks2
//
//  Created by David Cava Jimenez on 28/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//


import CoreData

extension Pdf: ManagedObjectType{
    
    public static var entityName:String { get { return "Pdf" } }
    
    
    
    class func fetchRequestTags(book : Book) -> NSFetchRequest<Pdf> {
        let fetchRequest: NSFetchRequest<Pdf> = Pdf.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        
       // let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        fetchRequest.predicate = NSPredicate(format: " book == %@", book)

       // fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        
        return fetchRequest
    }
    
    
}
