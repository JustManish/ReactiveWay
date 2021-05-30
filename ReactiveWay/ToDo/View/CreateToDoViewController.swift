//
//  CreateToDoViewController.swift
//  ReactiveWay
//
//  Created by mac on 26/05/21.
//

import UIKit

class CreateToDoViewController: UIViewController{

    @IBOutlet weak var toDoTitleField: UITextField!
    @IBOutlet weak var toDoView: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    
    var todoViewModel : ToDoViewModel = ToDoViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnSave.setRoundCorner(BorderColor: .systemPink, CornerRadius: 24, andBorderWidth: 2)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionSave(_ sender: UIButton) {
        self.dismiss(animated: true) {
            
            guard let title = self.toDoTitleField.text , let desc = self.toDoView.text , !title.isEmpty else {
                return
            }
            DispatchQueue.global(qos: .background).async {
                self.todoViewModel.onCreateNewToDo(title: title, description: desc)
            }
        }
        
        
    }

}
