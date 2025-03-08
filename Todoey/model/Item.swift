//
//  Item.swift
//  Todoey
//
//  Created by viraj shah on 08/03/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item:Object{
    @objc dynamic var title:String = ""
    @objc dynamic var ismark:Bool = false
//    inverse relationship
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
