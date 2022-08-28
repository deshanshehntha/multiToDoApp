//
//  TrackerViewController.swift
//  multiToDoApp
//
//  Created by Deshan Wattegama on 2022-08-25.
//

import Foundation
import UIKit


class TrackerViewController: UIViewController{
    
    @IBOutlet var todo1: UILabel!
    @IBOutlet var todo2: UILabel!
    @IBOutlet var todo3: UILabel!

    @IBOutlet var event1: UILabel!
    @IBOutlet var event2: UILabel!
    @IBOutlet var event3: UILabel!
    
    @IBOutlet var diaryEntry1: UITextView!

    private var todoList = [ToDoListItemTab]()
    private var eventList = [EventEntity]()
    private var diaryList = [DiaryItemList]()
    
    let context = (UIApplication.shared.delegate as!
                   AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {

        let image = UIImage(named: "HeaderBg.jpg")
        let appearance = UINavigationBarAppearance()
        appearance.backgroundImage = UIImage(named: "HeaderBg.jpg")
    
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
    
        getAllTodoItems()
        getAllEventItems()
        getDiarytItems()
        setUpUI()
    }
    
    func setUpUI() {
        
        if(todoList.isEmpty || todoList.count < 3) {
            todo1.text = ""
            todo2.text = ""
            todo3.text = ""
        } else if(todoList.count >= 3) {
            todo1.text = todoList[0].note!
            todo2.text = todoList[1].note!
            todo3.text = todoList[2].note!
        }
        
        if(eventList.isEmpty || eventList.count < 3) {
            event1.text = ""
            event2.text = ""
            event3.text = ""
        } else if(eventList.count >= 3) {
            event1.text = eventList[0].title!
            event2.text = eventList[1].title!
            event3.text = eventList[2].title!
        }

        if(diaryList.isEmpty) {
            diaryEntry1.text = ""
            
        } else {
            diaryEntry1.text = diaryList[0].diaryDescription!
            
        }
        
    }

    
    func getAllTodoItems(){
        do {
            todoList = try context.fetch(ToDoListItemTab.fetchRequest())
            }
        catch {
            print("Fetching failed.")
        }
    }
    
    func getAllEventItems(){
        do {
            eventList = try context.fetch(EventEntity.fetchRequest())
            }
        catch {
            print("Fetching failed.")
        }
    }
    
    func getDiarytItems(){
        do {
            diaryList = try context.fetch(DiaryItemList.fetchRequest())
            }
        catch {
            print("Fetching failed.")
        }
    }
    
    
    
    

}
