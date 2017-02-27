//
//  JsonParserServiceCoreDataImpl.swift
//  HackerBooks2
//
//  Created by David Cava Jimenez on 22/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import Foundation
import CoreData


public class JsonParserServiceCoreDataImpl{
    
    
var context: NSManagedObjectContext
    
    
    init(_ context: NSManagedObjectContext) {
        self.context = context
    }
    

func decode( withDataJson data: Data ) ->Void {
    let jsonSerializado = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    if let jsonArrayDictionary = jsonSerializado as? Array<AnyObject>{
        for item in jsonArrayDictionary {
            if let bookLibrary = item as? [ String : String ]{
                  decode(withDictionary: bookLibrary)
            }
        }
    }
    do {
        try context.save()
    } catch {
        print( "\(error.localizedDescription)" )
    }
    
}


func decode( withDictionary dictionary: Dictionary<String,String> ) -> Void{
    
    let authors = dictionary["authors"]
    let imageurl = dictionary["image_url"]
    let pdfurl = dictionary["pdf_url"]
    let title = dictionary["title"]
    let tags = dictionary["tags"]?.components(separatedBy: ",")
    
    
    
     print("\(tags?[0])")
    
    
    
    //el compilador infiere el tipo porque sabe que se está 
    //llamando para un objeto Book, cágate lorito¡
    let libro : Book = context.insertObject()
    //Inizializo por pattern maching
    (libro.authors,libro.imageurl,libro.pdfurl,libro.title) = (authors,imageurl, pdfurl, title)
  
    /* tags.map{ value in
            let tag : Tag = context.insertObject()
            tag.title = value
            libro.addToTags( tag )
            }*/
    
    for value in tags!{
        
       let key = value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
       let queryRequest = Tag.fetchRequestTagByTitle( key )
        
         let result = try! context.fetch( queryRequest )
        
        if result.count == 0{
        
        let tag : Tag = context.insertObject()
        tag.title = value.uppercased()
        libro.addToTags( tag )
        }
    
    }
}

}
