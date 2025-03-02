//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData
//because we implemented the UITableViewController direclty we don't need to add the self.datadelegate and self.datasource.

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)
        loadItem()
        
    }
    
//    MARK: - Saving and loading methodes of Coredata.
    
    func saveData(){
        //saving the data in deafaults.
        do{
            try context.save()
        }catch{
            print("Error while saving context \(error)")
        }
        self.tableView.reloadData()
    }

    func loadItem(){
        let request:NSFetchRequest<Item> = Item.fetchRequest()
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("Error in loading data: \(error)")
        }
        tableView.reloadData()
    }
    
    //    MARK: - Adding new Item in todey.
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var texFiled = UITextField()
        
        let alert = UIAlertController(title: "Add new item in todey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
            
            //what will happen when user click on addITem button
            print(texFiled.text!)
            
            if let a = texFiled.text{
                let newItem = Item(context: self.context)
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
    
    
//MARK: - Table View DataSource Methode
    
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
    
    
    //MARK: - Table View Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print(itemArray[indexPath.row])
        
        //for selcting a particular row  tableView.cellForRow()
        
        itemArray[indexPath.row].ismark = !itemArray[indexPath.row].ismark   //changing the ismark
    
        self.saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

//MARK: - UISearchBar Delegate Methodes.s
extension TodoListViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request :NSFetchRequest<Item> = Item.fetchRequest()
        
//        predicate means querying in the coredata.
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.predicate = predicate
        
//        sorting the data on the basis of title
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("Error in Filtering data: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        means if search bar contain zero element
        if searchBar.text?.count == 0{
            loadItem()
//            the keyboard and coursel is dismissed.
            DispatchQueue.main.async{
                searchBar.resignFirstResponder()
            }
            
        }
    }
}
