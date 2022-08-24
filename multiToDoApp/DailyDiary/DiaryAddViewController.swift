//
//  DiaryAddViewController.swift
//  multiToDoApp
//
//  Created by Ransi on 2022-08-24.
//

import UIKit

class DiaryAddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

       
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
    

    

}
