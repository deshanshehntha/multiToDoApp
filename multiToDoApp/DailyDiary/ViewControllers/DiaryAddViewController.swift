//
//  DiaryAddViewController.swift
//  multiToDoApp
//
//  Created by Ransi on 2022-08-24.
//

import UIKit
import Foundation
import CoreData

class DiaryAddViewController: UIViewController {
    
    //Outlets
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionField: UITextView!
    
    var selectedDiaryEntry: DiaryItemList? = nil
    
    override func viewDidLoad() {
        let image = UIImage(named: "HeaderBg.jpg")
        let appearance = UINavigationBarAppearance()
        appearance.backgroundImage = UIImage(named: "HeaderBg.jpg")
        
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        viewStoredData()
        
        if(selectedDiaryEntry != nil)
        {
            //            datePicker.date = selectedDiaryEntry?.createdAt
            descriptionField.text = selectedDiaryEntry?.diaryDescription
        }
        
    }
    
    //Hide the keyboard
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    // Add Record
    @IBAction func onDiaryEntry(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if(selectedDiaryEntry == nil)
        {
            let entity = NSEntityDescription.entity(forEntityName: "DiaryItemList", in: context)
            let newDiaryRecord = DiaryItemList(entity: entity!, insertInto: context)
            newDiaryRecord.id = diaryDataList.count as NSNumber
            newDiaryRecord.createdAt = datePicker.date
            newDiaryRecord.diaryDescription = descriptionField.text
            do {
                try context.save()
                diaryDataList.append(newDiaryRecord)
                navigationController?.popViewController(animated: true)
            }
            catch
            {
                print("Context Save Error!!!")
            }
            // Update Record
        }else {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DiaryItemList")
            do
            {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let diary = result as! DiaryItemList
                    if(diary == selectedDiaryEntry)
                    {
                        diary.createdAt = datePicker.date
                        diary.diaryDescription = descriptionField.text
                        
                        try context.save()
                        navigationController?.popViewController(animated: true)
                        
                    }
                    
                }
            }
            catch
            {
                print("Fetch Failed!!!")
            }
        }
    }
    
    
    // Delete Record
    @IBAction func deleteDiaryEntry(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DiaryItemList")
        do
        {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                let diary = result as! DiaryItemList
                if(diary == selectedDiaryEntry)
                {
                    //                    diary.deletedAt = Date()
                    context.delete(diary)
                    try context.save()
                    navigationController?.popViewController(animated: true)
                    
                }
                
            }
        }
        catch
        {
            print("Fetch Failed!!!")
        }
    }
    
    
    
    //Toast Message
    func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    //    self.showToast(message: "Success...", seconds: 1.0)
    
}



// View Stored data
func viewStoredData()
{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName:"DiaryItemList")
    do
    {
        let diaryData = try context.fetch(request) as! [DiaryItemList]
        if(diaryData.count > 0 ){
            
            diaryData.forEach {diaryDataObj in
                
                print("------------Diary--------------")
                print("Id",diaryDataObj.id ?? "")
                print("Created At:", diaryDataObj.createdAt ?? "00/00/0000-00:00:00")
                print("Diary Description:", diaryDataObj.diaryDescription ?? "Test")
            }
            
        }
        else
        {
            print("No results found")
        }
    }
    catch
    {
        print("Error in fetching items")
    }
}


