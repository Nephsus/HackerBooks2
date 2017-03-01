//
//  GetBooksInteractor.swift
//  HackerBooks
//
//  Created by David Cava Jimenez on 21/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import Foundation
import CoreData

public class GetBooksInteractor{

    var context: NSManagedObjectContext!

    func executeOperation(WithCompletionBlock finishedBlock: (() ->())? = nil ) -> Void {
        let apiManager : HackerBooksAPIManager = HackerBooksAPIManagerURLSessionImpl()
        
        let request = URLRequest(url: UtilsStatics.URLJSONRESOURCEBOOKS )
        
        apiManager.callOperation(WithRequest: request) { (data : Data?, error : Error?) in
            
            
           //hay que controlar los errores DCJ
            let service = JsonParserServiceCoreDataImpl( self.context! )
            
            service.decode(withDataJson:  data! )
          
          
            
            
            
            if  finishedBlock != nil{
                        finishedBlock!()
            }
        }
        
        
        
    }
    



}
