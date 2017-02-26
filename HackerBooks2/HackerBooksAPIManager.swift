//
//  HackerBooksAPIManager.swift
//  HackerBooks
//
//  Created by David Cava Jimenez on 21/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import Foundation


typealias ManagerResponse = (Data?, Error?) -> ()

protocol HackerBooksAPIManager:class {
    
    
    func callOperation(WithRequest request: URLRequest,
                       andCompletionBlock block: @escaping ManagerResponse ) -> Void;
    
}
