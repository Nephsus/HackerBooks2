//
//  HackerBooksAPIManagerURLSessionImpl.swift
//  HackerBooks
//
//  Created by David Cava Jimenez on 21/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import Foundation


public class HackerBooksAPIManagerURLSessionImpl: HackerBooksAPIManager{

    
    
    static let sharedInstanceSession: URLSession = {
        
        let instance = URLSession(configuration: URLSessionConfiguration.default,
                                  delegate: nil,
                                  delegateQueue: nil)
        return instance
    }()
    

    func callOperation(WithRequest request: URLRequest,
                       andCompletionBlock block: @escaping ManagerResponse ) -> Void {
        
       let task =  HackerBooksAPIManagerURLSessionImpl.sharedInstanceSession.dataTask(with: request)
                        { (data : Data?, response: URLResponse?, error : Error? ) in
                            
                let resp = String(data: data!, encoding: String.Encoding.utf8)
                print( "\( resp )" )
                block(data, error)
                            
        }
        
        task.resume()
        
    }
}
