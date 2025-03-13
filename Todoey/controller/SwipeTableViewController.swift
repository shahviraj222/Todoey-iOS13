//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by viraj shah on 13/03/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController,SwipeTableViewCellDelegate{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        // handle action by updating model with deletion
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            print("Category is deleted")
            
//            if let categoryToDeleted = self.categoryArray?[indexPath.row] {
//                do{
//                    try self.realm.write{
//                        self.realm.delete(categoryToDeleted)
//                    }
//                }
//                catch{
//                    print("Error in deleting Item \(error)")
//                }
//            }
//            tableView.reloadData() // automatically the editActionsOptionsForRowAt call the reload method
            
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")

        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    

}
