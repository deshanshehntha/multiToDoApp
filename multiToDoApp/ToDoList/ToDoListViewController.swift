//
//  ToDoListController.swift
//  multiToDoApp
//
//  Created by user219465 on 8/21/22.
//

import UIKit
import CoreData

class ToDoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var AddItemButton: UIButton!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var listTableView: UITableView! = {
        let listTable = UITableView()
        listTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return listTable
    }()
    
    private var models = [ToDoListItemTab]()
    
    let dateFormatter = DateFormatter()
    //dateFormatter.dateFormat = "yyyy-MM-dd"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(listTableView)
        //listTableView.delegate = self
        //listTableView.dataSource = self
        //listTableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = listTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.note
        return cell
    }
    
    @IBAction func onClickAddItem(_ sender: Any) {
        /*let myDatePicker: UIDatePicker = UIDatePicker()
            myDatePicker.preferredDatePickerStyle = .wheels
            myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)*/
        
        let alert = UIAlertController(title: "New To Do Item", message: "Enter New To Do Item", preferredStyle: .alert)
        
        //alert.view.addSubview(myDatePicker)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Note"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Note Description"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Status"
        }
        
        let continueAction = UIAlertAction(title: "Submit",style: .default) { [weak alert] _ in
            guard let textFields = alert?.textFields else { return }
                                            
            if let noteText = textFields[0].text,
            let noteDescText = textFields[1].text,
               let statusText = textFields[2].text {

                   self.createToDoItem(note: noteText, noteDesc: noteDescText, plannedDate: Date(), status: statusText)                      }
        }
        alert.addAction(continueAction)
        
        present(alert, animated: true)
    }
    func getAllListItems(){
        do {
            models = try context.fetch(ToDoListItemTab.fetchRequest())
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
        }
        catch {
            //error
        }
    }
    
    func createToDoItem(note: String, noteDesc: String, plannedDate: Date, status: String){
        let newItem = ToDoListItemTab(context: context)
        newItem.note = note
        newItem.noteDescription = noteDesc
        newItem.plannedDate = plannedDate
        newItem.status = status
        newItem.createdAt = Date()
        
        do {
            try context.save()
            getAllListItems()
            print("Harini")
            models = try context.fetch(ToDoListItemTab.fetchRequest())
            print(models)
        }catch {
            //error
        }
        
    }
    
    func deleteToDoItem(item: ToDoListItemTab){
        context.delete(item)
        
        do {
            try context.save()
            getAllListItems()
        }catch {
            //error
        }
    }
    
    func updateToDoItem(item: ToDoListItemTab, newNote: String, newNoteDesc: String, newPlannedDate: Date, newStatus: String){
        item.note = newNote
        item.noteDescription = newNoteDesc
        item.plannedDate = newPlannedDate
        item.status = newStatus
        
        do {
            try context.save()
            getAllListItems()
        }catch {
            //error
        }
    }

}
