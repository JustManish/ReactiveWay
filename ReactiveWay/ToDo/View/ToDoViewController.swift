//
//  ViewController.swift
//  ReactiveWay
//
//  Created by mac on 26/05/21.
//

import UIKit

protocol ToDoView{
    
    func addNewToDo()
    func removeToDoItem(at index : Int)
    func markDoneToDoItem(at index : Int)
}

class ToDoViewController: UIViewController {
    
    @IBOutlet weak var btnAddToDo: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var todoViewModel : ToDoViewModel = ToDoViewModel.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        todoViewModel.vc = self
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}



//MARK : - ToDo Data Source
extension ToDoViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoViewModel.toDoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        cell.textLabel?.text = self.todoViewModel.toDoList?[indexPath.row].todoTitle
        cell.detailTextLabel?.text = self.todoViewModel.toDoList?[indexPath.row].todoDescription
        return cell
    }
    
}



//MARK : - ToDo Delegate

extension ToDoViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.todoViewModel.toDoList?[indexPath.row].didSelectToDoItem()
    }
    
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let itemViewModel = self.todoViewModel.toDoList?[indexPath.row]
        
        var menuActions : [UIContextualAction] = []
        
        let menuItems = itemViewModel?.menuItems
        
       _ = menuItems?.map({ (menuItem) -> (Void) in
            
            let menuAction = UIContextualAction(style: .normal, title: menuItem.title) { (action, view, success: (Bool) -> Void) in
                
                let delegate = menuItem as? ToDoMenuItemViewDelegate
                
                DispatchQueue.global(qos: .background).async {
                    delegate?.onMenuItemselected()
                }
                success(true)
            }
            menuAction.backgroundColor = UIColor(hexString: menuItem.color)
        
        menuActions.append(menuAction)
            
        })
        
        return UISwipeActionsConfiguration(actions: menuActions)
    }
}
    


extension ToDoViewController : ToDoView{
    func markDoneToDoItem(at index: Int) {
        print("Marked Done todo Item")
    }
    
    
    
    func removeToDoItem(at index: Int) {
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    
    func addNewToDo() {
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: (self.todoViewModel.toDoList!.count) - 1, section: 0)], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    
}
