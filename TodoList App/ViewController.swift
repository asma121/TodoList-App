//
//  ViewController.swift
//  TodoList App
//
//  Created by admin on 18/12/2021.
//

import UIKit

struct Item {
    var title:String?
    var note:String?
    var date:Date?
    var isChecked:Bool = false
}


protocol SaveItemDelegate{
    func saveItem( controller : ViewController , item : Item)
}

class ViewController: UIViewController {

    @IBOutlet weak var titileTF: UITextField!
    @IBOutlet weak var noteTV: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate : SaveItemDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func addItemButtonPressed(_ sender: UIButton) {
        var newItem = Item()
        if let title = titileTF.text {
            if let note = noteTV.text {
               // print(note)
                newItem.title = title
                newItem.note = note
                newItem.date = datePicker.date
                newItem.isChecked = false
            }
        }

        delegate?.saveItem(controller : self , item: newItem)
        navigationController?.popViewController(animated: true)
    }
}

