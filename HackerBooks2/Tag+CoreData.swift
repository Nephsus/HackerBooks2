//
//  Tag+CoreData.swift
//  HackerBooks2
//
//  Created by David Cava Jimenez on 25/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import CoreData



extension Tag: ManagedObjectType{
    
    public static var entityName:String { get { return "Tag" } }
    
    
    class func fetchRequestTagByTitle(_ title: String ) -> NSFetchRequest<Tag> {
        let fetchRequest: NSFetchRequest<Tag> = Tag.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchRequest.predicate = NSPredicate(format: " title = '@%'", title)
        
        
        return fetchRequest
    }
    
    
    class func fetchRequestTags() -> NSFetchRequest<Tag> {
        let fetchRequest: NSFetchRequest<Tag> = Tag.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
            
        
        return fetchRequest
    }

    
    
    
}
