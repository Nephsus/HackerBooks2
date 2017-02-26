//
//  NSManagedObjectContext.swift
//  HackerBooks2
//
//  Created by David Cava Jimenez on 22/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//


import CoreData

extension NSManagedObjectContext{
   
    public func insertObject<A: NSManagedObject where A:ManagedObjectType> () -> A{
    
         guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A
            else {fatalError("La cagamos compadre")}
        
       
         return obj
    
    }



}
