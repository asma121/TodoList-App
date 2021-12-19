//
//  TableViewController.swift
//  TodoList App
//
//  Created by admin on 18/12/2021.
//

import UIKit
import CoreData

class TableViewController: UITableViewController , SaveItemDelegate {
    
    var items = [ItemEntity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getItem()

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let formartter = DateFormatter()
        formartter.dateFormat = "MM/dd/yyyy"
        let dateF = formartter.string(from: items[indexPath.row].date!)
        cell.titleLabel.text = items[indexPath.row].title
        cell.noteLabel.text = items[indexPath.row].note
        cell.dateLabel.text = dateF
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ViewController
        destination.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            items[indexPath.row].isChecked = false
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            items[indexPath.row].isChecked = true
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        deleteItem(itemTitle: items[indexPath.row].title!)
    }
    
    func saveItem( controller : ViewController , item: Item) {
        storeItem(item: item)
    }

}

extension TableViewController {

    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    func storeItem(item : Item){
        let context = getContext()
        let itemE = ItemEntity.init(context: context)
        itemE.title = item.title
        itemE.note = item.note
        itemE.date = item.date
        itemE.isChecked = item.isChecked

        do{
            try context.save()
            getItem()
        }catch{
            print(error.localizedDescription)
        }
    }

    func getItem() {
        let context = getContext()
        let request = NSFetchRequest<ItemEntity>.init(entityName: "ItemEntity")

        do{
            items = try context.fetch(request)
            tableView.reloadData()
        }catch{
            print(error.localizedDescription)
        }
    }
//
//    func updateItem(oldItemTitle:String , newItemText:String){
//            let context = getContext()
//            let request = NSFetchRequest<ItemEntity>.init(entityName: "ItemEntity")
//            let predicate = NSPredicate.init(format: "text == %@", oldItemText)
//        request.predicate = predicate
//
//        do{
//            let arr = try context.fetch(request)
//            let item = arr.first
//            item?.text = newItemText
//            try context.save()
//            getItem()
//        }catch{
//            print(error.localizedDescription)
//        }
//    }

    func deleteItem(itemTitle : String ){
        let context = getContext()
        let request = NSFetchRequest<ItemEntity>.init(entityName: "ItemEntity")
        let predicate = NSPredicate.init(format: "title == %@", itemTitle)
        request.predicate = predicate

        do{
            if let item = try context.fetch(request).first {
                context.delete(item)
                try context.save()
                getItem()
            }
        }catch{
            print(error.localizedDescription)
        }
    }
}
