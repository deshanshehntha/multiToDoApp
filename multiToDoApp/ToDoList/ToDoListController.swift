//
//  ToDoListController.swift
//  multiToDoApp
//
//  Created by user219465 on 8/21/22.
//

import UIKit

class ToDoListController: UIViewController ,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var HeaderImage: UIImageView!
    
    @IBOutlet weak var AddItemButton: UIButton!
    @IBOutlet weak var SubView: UIView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var listTableView: UITableView! = {
        let listTable = UITableView()
        listTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return listTable
    }()
    
    private var models = [ToDoListItemTab]()
    
    var myDatePicker: UIDatePicker = UIDatePicker()
    var addAlert = UIAlertController()
    var updateAlert = UIAlertController()
    
    
    let dateFormatter = DateFormatter()
    //dateFormatter.dateFormat = "yyyy-MM-dd"
    
    override func viewDidLoad() {

        let image = UIImage(named: "HeaderBg.jpg")
        let appearance = UINavigationBarAppearance()
        appearance.backgroundImage = UIImage(named: "HeaderBg.jpg")
    
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        SubView.addSubview(listTableView)
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.frame = view.bounds
        self.addDummyData()
        getAllListItems()

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]
        
        createDatePicker()
        let sheet = UIAlertController(title: "To Do Item", message: nil, preferredStyle: .actionSheet)

        sheet.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Update", style: .default, handler: { [self]_ in
            self.updateAlert = UIAlertController(title: "Update To Do Item", message: nil, preferredStyle: .alert)

            self.updateAlert.addTextField { (textField) in
                textField.placeholder = "Note"
                textField.text = item.note
                textField.keyboardType = .emailAddress
            }
            self.updateAlert.addTextField { (textField) in
                textField.placeholder = "Note Description"
                textField.text = item.noteDescription
                textField.keyboardType = .emailAddress
            }
            
            self.updateAlert.addTextField { (textField) in
                textField.placeholder = "Status"
                textField.text = item.status
                textField.keyboardType = .emailAddress
            }
            updateAlert.addTextField { (textField) in
                textField.placeholder = "YYYY-MM-DD"
                textField.text = item.plannedDate?.description
                textField.inputView = self.myDatePicker
                let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.dateUpdChanged))
                let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 44))
                toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
                textField.inputAccessoryView = toolBar
            }
            
            let editAction = UIAlertAction(title: "Update",style: .default) { [weak updateAlert] _ in
                guard let textFields = updateAlert?.textFields else { return }
                                                
                if let noteText = textFields[0].text,
                let noteDescText = textFields[1].text,
                   let statusText = textFields[2].text {

                    self.updateToDoItem(item: item, newNote: noteText, newNoteDesc: noteDescText, newPlannedDate: self.myDatePicker.date, newStatus: statusText)
                }
            }
               let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                   print("Cancel button tapped")
               }
            
            updateAlert.addAction(editAction)
            updateAlert.addAction(cancel)
            self.present(updateAlert, animated: true)
        }))
        sheet.addAction(UIAlertAction(title:"Delete", style: .destructive, handler: {[weak self] _ in
            self?.deleteToDoItem(item: item)
        }))
        present(sheet, animated: true)
    }

    @IBAction func onClickAddItem(_ sender: Any) {
        createDatePicker()
        addAlert = UIAlertController(title: "New To Do Item", message: "Enter New To Do Item", preferredStyle: .alert)
        
        addAlert.addTextField { (textField) in
            textField.placeholder = "Note"
            textField.keyboardType = .emailAddress
        }
        
        addAlert.addTextField { (textField) in
            textField.placeholder = "Note Description"
            textField.keyboardType = .emailAddress
        }
        
        addAlert.addTextField { (textField) in
            textField.placeholder = "Status"
            textField.keyboardType = .emailAddress
        }
        
        addAlert.addTextField { (textField) in
            textField.placeholder = "YYYY-MM-DD"
            textField.inputView = self.myDatePicker
            let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.dateChanged))
            let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 44))
            toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
            textField.inputAccessoryView = toolBar
        }
        
        let continueAction = UIAlertAction(title: "Submit",style: .default) { [weak addAlert] _ in
            guard let textFields = addAlert?.textFields else { return }
                                            
            if let noteText = textFields[0].text,
            let noteDescText = textFields[1].text,
               let statusText = textFields[2].text {

                self.createToDoItem(note: noteText, noteDesc: noteDescText, plannedDate: self.myDatePicker.date, status: statusText)                      }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        addAlert.addAction(continueAction)
        addAlert.addAction(cancel)
        
        present(addAlert, animated: true)
    }
    
    func createDatePicker(){
        myDatePicker.preferredDatePickerStyle = .wheels
        myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
        myDatePicker.timeZone = .current
        myDatePicker.backgroundColor = UIColor.white
        myDatePicker.datePickerMode = .dateAndTime
    }
    
    @objc func dateChanged() {
        addAlert.textFields?.last?.text = "\(myDatePicker.date)"
        print(myDatePicker.date)
    }
    
    @objc func dateUpdChanged() {
        updateAlert.textFields?.last?.text = "\(myDatePicker.date)"
        print(myDatePicker.date)
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
    func addDummyData(){
        createToDoItem(note: "Exam", noteDesc: "Big Data", plannedDate: Date(), status: "Initial")
        createToDoItem(note: "Cleaning", noteDesc: "Room", plannedDate: Date(), status: "In Progress")
    }
    
}
