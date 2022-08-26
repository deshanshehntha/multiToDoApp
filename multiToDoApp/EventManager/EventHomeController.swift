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
    var historyData = [EventDataDTO]()

    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        super.viewWillAppear(true)

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


    func fetchData()
    {
        
        historyData.removeAll()
        
        do {

            let data = try context.fetch(EventEntity.fetchRequest())
            rowCount = data.count
            
            for entry in data {
                
                let title = entry.title!
                let description = entry.eventDescription!
                let url = entry.url!
                let date = entry.date!
                let identifier = entry.identifier!
               
                historyData.append(EventDataDTO(title: title, eventDescription:  description, url: url, date: date, identifier: identifier))
            }
            
            
        } catch let error as NSError {
            print("Fetching failed. \(error), \(error.userInfo)")
        }
    }
    
}
