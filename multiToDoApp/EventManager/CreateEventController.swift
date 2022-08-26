//
//  EventManagerController.swift
//  multiToDoApp
//
//  Created by Deshan Wattegama on 2022-08-25.
//

import Foundation
import UIKit
import CoreData


class CreateEventController: UIViewController {
    
    @IBOutlet var eventTitleInput:UITextField!
    @IBOutlet var eventDescriptionInput:UITextField!
    @IBOutlet var urlInput:UITextField!
    @IBOutlet var dateInput:UITextField!
    @IBOutlet var createButton:UIButton!

    var eventTitle: String = ""
    var eventDescription: String = ""
    var url: String = ""
    var date: String = ""
    var event : EventEntity?
    var context : NSManagedObjectContext {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.persistentContainer.viewContext
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: "HeaderBg.jpg")
        let appearance = UINavigationBarAppearance()
        appearance.backgroundImage = UIImage(named: "HeaderBg.jpg")

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
            view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func onCreateButtonPressed() {
        
        eventTitle = eventTitleInput.text!
        eventDescription = eventDescriptionInput.text!
        url = urlInput.text!
        date = ""
        
        let identifier = String(NSDate().timeIntervalSince1970)

        _ = EventEntity.init(title: eventTitle, eventDescription: eventDescription, url: url, date: date, identifier: identifier, insertIntoManagedObjectContext: self.context)

        do
        {
            try self.context.save()
        }
        catch let error as NSError {
                print("Saving failed. \(error), \(error.userInfo)")
        }
        
    

    }
    
}
