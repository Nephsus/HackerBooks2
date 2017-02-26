//
//  ManagedObjectType.swift
//  HackerBooks2
//
//  Created by David Cava Jimenez on 22/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import Foundation

public protocol ManagedObjectType: class{

    static var entityName:String { get }
    //static var defaultSortDescriptors:[]



}
