//
//  Photo.swift
//  HackerBooks2
//
//  Created by David Cava Jimenez on 28/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import CoreData

extension Photo: ManagedObjectType{
    
    public static var entityName:String { get { return "Photo" } }
}
