//
//  tmep.swift
//  Todoey
//
//  Created by viraj shah on 28/02/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//



import Foundation
import UIKit

//implementing the database : using default database.

//var itemArray = [Item]()
//let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

//func save(){
//    let encoder = PropertyListEncoder()
////encode data
//    do{
//        let data = try encoder.encode(itemArray)
//        try data.write(to: dataFilePath!)
//    }catch{
//        print("Error in saving data\(error)")
//    }
//}
//
//func load(){
//    if let data = try? Data(contentsOf: dataFilePath!){
//        let decoder = PropertyListDecoder()
//        do{
//            itemArray = try decoder.decode([Item].self, from: data)
//        }catch{
//            print("Error in loading data\(error)")
//        }
//        
//    }
//    
//}


//tableview datasource method : 1)numberOfRowsInSection 2)cellForRowAt

//func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return itemArray.count
//}
//
//func tableview(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for:indexPath)
//    cell.textLabel?.text = itemArray[indexPath.row].title
//    return cell
//}

