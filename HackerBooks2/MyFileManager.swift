//
//  FileManager.swift
//  HackerBooks
//
//  Created by David Cava Jimenez on 28/1/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import Foundation


struct MyFileManager {
    
    
    
    static func urlDocumentAppendStringPath(endedPath: String) -> URL{
    
    
        let fileManager = FileManager.default
        var ulrToDocuments = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        ulrToDocuments.appendPathComponent( endedPath )
    
        return ulrToDocuments
    
    }
    
    
    
}
