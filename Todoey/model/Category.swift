//
//  Category.swift
//  Todoey
//
//  Created by viraj shah on 08/03/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category:Object{
    @objc dynamic var name:String = ""
//    declaring relationship one to many
    let items = List<Item>() // array = Array<Int>()
}
