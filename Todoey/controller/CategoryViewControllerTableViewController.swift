//
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by viraj shah on 02/03/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewControllerTableViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
                let newItem = Category(context: self.context)
                newItem.name = a
                self.categoryArray.append(newItem)
            }
            self.saveData()
            
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
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
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
            destinationVc.selectedCategory = categoryArray[indexPath.row]  // passing value to variable
        }
    }
    
//    MARK: - Save and Load Methods
    func saveData(){
        do{
            try context.save()
        }catch{
            print("Error in saving data.\(error)")
        }
        
    }
    
    func loadData(){
        let request :NSFetchRequest<Category>=Category.fetchRequest()
        do{
            categoryArray = try context.fetch(request)
        }catch{
            print("Error in loading data \(error)")
        }
    }
    
}
