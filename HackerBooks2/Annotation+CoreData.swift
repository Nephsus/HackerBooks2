//
//  Annotation+CoreData.swift
//  HackerBooks2
//
//  Created by David Cava Jimenez on 28/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import CoreData


extension Annotation: ManagedObjectType{
    
    public static var entityName:String { get { return "Annotation" } }
    
    
    class func fetchRequestByBook( book:Book  ) -> NSFetchRequest<Annotation> {
        let fetchRequest: NSFetchRequest<Annotation> = Annotation.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        let sortTag = NSSortDescriptor(key: "dateCreation", ascending: true)
        fetchRequest.sortDescriptors = [ sortTag ]
        fetchRequest.predicate = NSPredicate(format: " book == %@", book)
        
        return fetchRequest
    }
    
    
   
    
}

