//
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by viraj shah on 02/03/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryViewControllerTableViewController: UITableViewController {
    let realm = try! Realm()
    
    var categoryArray:Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    
    //    MARK: - Add New Category Method
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
            
            //what will happen when user click on addITem button
            print(textField.text!)
            
            if let a = textField.text{
                let newItem = Category()
                newItem.name = a
                
                self.saveData(category: newItem)
            }
            
            
            //            reloadData() call the datasource method again.
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new item"
            textField = alertTextField
            print(alertTextField.text!) //nothing printed here
            
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    //    MARK: - DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Category Added"
        return cell
    }
    
    //    MARK: - Data Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVc.selectedCategory = categoryArray?[indexPath.row]  // passing value to variable
        }
    }
    
    //    MARK: - Save and Load Methods
    func saveData(category:Category){
        do{
            try realm.write{
                realm.add(category)
            }
        }catch{
            print("Error in saving data.\(error)")
        }
        
    }
    
    func loadData(){
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }
}
