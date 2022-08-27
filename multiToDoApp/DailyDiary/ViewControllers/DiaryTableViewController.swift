//
//  DiaryTableViewController.swift
//  multiToDoApp
//
//  Created by Ransi on 2022-08-25.
//

import UIKit
import CoreData

var diaryDataList = [DiaryItemList]()

class DiaryTableViewController: UITableViewController {
    
    var firstLoad = true
    
    // Get non deleted record list
    func nonDeletedRecords() -> [DiaryItemList]
    {
        var nonDeletedRecordList = [DiaryItemList]()
        for diaryDataList in diaryDataList {
            if(diaryDataList.deletedAt == nil)
            {
                nonDeletedRecordList.append(diaryDataList)
            }
        }
        return nonDeletedRecordList
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchDiaryData()
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let diaryCell = tableView.dequeueReusableCell(withIdentifier: "DiaryDataIdentifier", for: indexPath)
        as! DiaryCell

        let thisDiary: DiaryItemList!
        thisDiary = diaryDataList[indexPath.row]
        diaryCell.diaryDescription.text = thisDiary.diaryDescription
        return diaryCell
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaryDataList.count
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // Fetch Data
    func fetchDiaryData() {
        if(firstLoad)
        {
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DiaryItemList")
            do
            {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let diary = result as! DiaryItemList
                    diaryDataList.append(diary)
                }
            }
                catch
                {
                    print("Fetch Failed!!!")
                }
            }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editDiaryEntry", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editDiaryEntry")
        {
            let indexPath = tableView.indexPathForSelectedRow!
            let diaryDetail = segue.destination as? DiaryAddViewController
            
            let selectedDiaryEntry: DiaryItemList!
            selectedDiaryEntry = diaryDataList[indexPath.row]
            diaryDetail!.selectedDiaryEntry = selectedDiaryEntry
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

   

}
