//
//  TrackerViewController.swift
//  multiToDoApp
//
//  Created by Deshan Wattegama on 2022-08-25.
//

import Foundation
import UIKit


class TrackerViewController: UIViewController{
    
    private var todoList = [ToDoListItemTab]()
    private var eventList = [EventEntity]()
    
    @IBOutlet var todo1: UILabel!
    @IBOutlet var todo2: UILabel!
    @IBOutlet var todo3: UILabel!

    @IBOutlet var event1: UILabel!
    @IBOutlet var event2: UILabel!
    @IBOutlet var event3: UILabel!
    
    @IBOutlet var diaryEntry1: UILabel!

    
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
        setUpUI()
    }
    
    func setUpUI() {
        todo1.text = todoList[0].note
        todo2.text = todoList[1].note
        todo3.text = todoList[2].note
        
        event1.text = eventList[0].title
        event2.text = eventList[1].title
        event3.text = eventList[2].title

        diaryEntry1.text = "asdasdadjknsadjknajkdnajksndjkakjdnajksdjnaljkdnaldkjsandanjfnwjrnlkjnfllkewnfkneslfknelfkenlwkfnelfnjklnfkndkfnklsfnewknf;eknfkenfkn'kfneklfnklewnfkelnfkwenfklsnfj;bw jflkwnf'lkwn"
        
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
    
    
    
    
    

}
