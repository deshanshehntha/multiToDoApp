//
//  ToDoListController.swift
//  multiToDoApp
//
//  Created by user219465 on 8/21/22.
//

import UIKit

class ToDoListController: UIViewController {

    @IBOutlet weak var HeaderImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HeaderImage.layer.cornerRadius = 10
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
