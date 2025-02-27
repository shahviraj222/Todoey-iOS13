//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

//because we implemented the UITableViewController direclty we don't need to add the self.datadelegate and self.datasource.

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)

        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
//                    itemArray = items
//                }
        loadItem()
    }
    
    func saveData(){
        //saving the data in deafaults.
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: self.dataFilePath!)
        }catch{
            print("Error Encoding ArryItems")
        }
        self.tableView.reloadData()
    }
    
    func loadItem(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Erooring While Decoding\(error)")
            }
            
        }
    }
    
    //Mark Table View DataSource Methode
    
    //        no of rows we have in our table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    //      for setting each row in the table view.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        itemArray[indexPath.row].ismark == true ? (cell.accessoryType = .checkmark) : (cell.accessoryType = .none)
        
//      cell.accessoryType = itemArray[indexPath.row].ismark ? .checkmark : .none
        
        return cell
    }
    
    //Mark Table View Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print(itemArray[indexPath.row])
        
        //for selcting a particular row  tableView.cellForRow()
        
        itemArray[indexPath.row].ismark = !itemArray[indexPath.row].ismark   //changing the ismark
    
        self.saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Mark Add item in todey list.
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var texFiled = UITextField()
        
        let alert = UIAlertController(title: "Add new item in todey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
            
            //what will happen when user click on addITem button
            print(texFiled.text!)
            
            if let a = texFiled.text{
                let newItem = Item()
                newItem.title = a
                self.itemArray.append(newItem)
            }
            
            self.saveData()

           
            
//            reloadData() call the datasource method again.
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new item"
            texFiled = alertTextField
            print(alertTextField.text!) //nothing printed here
            
        }
        
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
}

