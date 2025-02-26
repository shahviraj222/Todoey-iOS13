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
    
    var itemArray = ["Add water to plant","Buy Milk","Go to Courier Centre"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
    }
    
//Mark Table View DataSource Methode
    
    //        no of rows we have in our table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    
    //      for setting each row in the table view.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
//Mark Table View Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        //for selcting a particular row  tableView.cellForRow()
        
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var texFiled = UITextField()
        
        let alert = UIAlertController(title: "Add new item in todey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
//            what will happen when user click on addITem button
            print(texFiled.text)
            if let a = texFiled.text{
                self.itemArray.append(a)
            }
            self.tableView.reloadData()
            print("Success!")
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new item"
            texFiled = alertTextField
            print(alertTextField.text) //nothing printed here
          
        }
        
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
}

