//
//  ViewController.swift
//  HelloFikri
//
//  Created by Fikri on 14/05/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var saveItem: UITextField!
   
    
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = item {
            saveItem.text = item.name
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender as AnyObject? === saveButton{
            let name = saveItem.text ?? ""
            item = Item(name: name)
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isInAddMode = presentingViewController is UINavigationController
        
        if isInAddMode{
        dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
    
}

}



