//
//  ItemTableViewController.swift
//  HelloFikri
//
//  Created by Fikri on 01/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {

    var items = [Item]()
    //rubah
    func loadItems() -> [Item]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Item.archiveURL.path) as? [Item]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ini ada perubahan
        
        
        
        navigationItem.leftBarButtonItem = editButtonItem
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        //load saved items
        if let savedItems = loadItems() {
            items += savedItems
        }
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell

        // Configure the cell...
        let item = items[indexPath.row]
        cell.nameLabel.text = item.name

        return cell
    }
    
    @IBAction func unwindToList(sender: UIStoryboardSegue){
        let srcViewCon = sender.source as? ViewController
        let item = srcViewCon?.item
        if(srcViewCon != nil && item?.name != "") {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //update an existing meal
                items[selectedIndexPath.row] = item!
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                //add a new item
                           let newIndexPath = IndexPath(row: items.count, section: 0)
                           items.append(item!)
                           tableView.insertRows(at: [newIndexPath], with: .bottom)
                            func saveItems(){
                                   let isSaved = NSKeyedArchiver.archiveRootObject(items, toFile: Item.archiveURL.path)
                                   
                                   if !isSaved{
                                       print("Failed to save items...")
                                   }
                               }
            }
           
        }
    }
    
   
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: indexPath.row)
            func saveItems(){
                   let isSaved = NSKeyedArchiver.archiveRootObject(items, toFile: Item.archiveURL.path)
                   
                   if !isSaved{
                       print("Failed to save items...")
                   }
               }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! ViewController
    
        // Get the new view controller using segue.destination.
        if let selectedCell = sender as? ItemTableViewCell {
            let indexPath = tableView.indexPath(for: selectedCell)!
            let selectedItem = items[indexPath.row]
            detailVC.item = selectedItem
        }
    }
        else if segue.identifier == "addItem" {
            
        }
        // Pass the selected object to the new view controller.
    }
    

}
