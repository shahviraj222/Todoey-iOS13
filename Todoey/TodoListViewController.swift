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
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Buy Milk"
        newItem.ismark = true
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Apple"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Buy Banana"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
                    itemArray = items
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
    
        self.tableView.reloadData()
        
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
            
            //saving the data in deafaults.
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
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

