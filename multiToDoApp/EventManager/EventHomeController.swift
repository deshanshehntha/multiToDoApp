//
//  EventHomeController.swift
//  multiToDoApp
//
//  Created by Deshan Wattegama on 2022-08-25.
//

import Foundation
import UIKit
import CoreData

class EventHomeController: UICollectionViewController{
    
    var event : EventEntity?
    var context : NSManagedObjectContext {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.persistentContainer.viewContext
        }
    var rowCount: Int = 0
    var historyData = [EventEntity]()
    var alert = UIAlertController()
    var datePicker: UIDatePicker = UIDatePicker()
    var formatter = DateFormatter()
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        super.viewWillAppear(true)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"


        self.collectionView.reloadData()

    }
    
    override func viewDidLoad() {
        fetchData()

        super.viewDidLoad()

        let image = UIImage(named: "HeaderBg.jpg")
        let appearance = UINavigationBarAppearance()
        appearance.backgroundImage = UIImage(named: "HeaderBg.jpg")
    
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
    }

    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
            // 1
            return 1
        }


        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // 2
            return historyData.count
        }
    
    
    @objc func tap(_ sender: UITapGestureRecognizer) {

       let location = sender.location(in: self.collectionView)
       let indexPath = self.collectionView.indexPathForItem(at: location)

       if let index = indexPath {
          print("Got clicked on index: \(index)!")
       }
        
        showViewScreen(item: historyData[indexPath!.row])

    }
    
    func showViewScreen(item : EventEntity) {
        alert = UIAlertController(title: "View Your Event", message: "", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = "Title : " + item.title!
            textField.isEnabled = false
        }

        alert.addTextField { (textField) in
            textField.text =  "Desc : " + item.eventDescription!
            textField.isEnabled = false
        }

        alert.addTextField { (textField) in
            textField.text =  "url : " + item.url!
            textField.isEnabled = false
        }

        alert.addTextField { (textField) in
            textField.text = item.date
            textField.isEnabled = false
        }
        
        let modifyAction = UIAlertAction(title: "Modify", style: .default) { [weak alert] _ in
            self.showEditScreen(item: item)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            self.alert.dismiss(animated: true)
        }

        alert.addAction(modifyAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
        
    }
    
    func showEditScreen(item : EventEntity) {
        alert = UIAlertController(title: "Edit Your Event", message: "", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = item.title
            textField.isEnabled = true
        }

        alert.addTextField { (textField) in
            textField.text = item.eventDescription
            textField.isEnabled = true
        }

        alert.addTextField { (textField) in
            textField.text = item.url
            textField.isEnabled = true
        }

        alert.addTextField { (textField) in
            textField.text = item.date
            textField.inputView = self.datePicker
            let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.dateUpdateValueChanged))
            let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 80))
            toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
            textField.inputAccessoryView = toolBar
        }
        
        
        let submitAction = UIAlertAction(title: "Update",style: .default) { [weak alert] _ in
            guard let textFields = alert?.textFields else { return }
                                            
            if let title = textFields[0].text,
            let description = textFields[1].text,
            let url = textFields[2].text {
                
                item.title = title
                item.eventDescription = description
                item.url = url
                item.date = self.formatter.string(from: self.datePicker.date)

                self.updateEvent(item: item)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            self.alert.dismiss(animated: true)
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) -> Void in
            self.deleteEvent(item: item)
            self.alert.dismiss(animated: true)
        }

        alert.addAction(submitAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
        
    }

    
    @objc func dateUpdateValueChanged() {
        alert.textFields?.last?.text = "\(datePicker.date)"
    }
    
    

        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
            // Configure the cell
            // 3
            if let label = cell.viewWithTag(100) as? UILabel {
                label.text = historyData[indexPath.row].title
            }
            
            if let label = cell.viewWithTag(101) as? UILabel {
                label.text = historyData[indexPath.row].date
            }
            
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        
            return cell
        }

    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "collectionReusableView", for: indexPath)
            return view
        }
        fatalError("Unexpected kind")
    }


    func updateEvent(item: EventEntity) {
        
        do
        {
            try self.context.save()
            fetchData()
            self.collectionView.reloadData()

        }
        catch let error as NSError {
                print("Saving failed. \(error), \(error.userInfo)")
        }

    
    }
    
    func deleteEvent(item: EventEntity) {
        do
        {
            try self.context.delete(item)
            
            do {
                try context.save()
                fetchData()
                self.collectionView.reloadData()
            }catch {
                //error
            }
        }
        catch let error as NSError {
            print("Delete failed. \(error), \(error.userInfo)")
        }
    }
    
    func fetchData()
    {
        
        historyData.removeAll()
        
        do {

            let data = try context.fetch(EventEntity.fetchRequest())
            rowCount = data.count
            
            for entry in data {
                historyData.append(entry)
            }
            
            
        } catch let error as NSError {
            print("Fetching failed. \(error), \(error.userInfo)")
        }
    }
    
}
