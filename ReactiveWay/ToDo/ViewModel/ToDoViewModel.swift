//
//  File.swift
//  ReactiveWay
//
//  Created by mac on 28/05/21.
//

import Foundation

protocol ToDoItemPresentable {
      
    var id : String? {get}
    var todoTitle : String? {get}
    var todoDescription : String? {get}
    var isDone : Bool? {get set}
    var menuItems : [MenuItemViewModel] {get}
}

protocol ToDoMenuItemPresentable {
    var title : String {get}
    var color : String {get}
}

protocol ToDoMenuItemViewDelegate {
    
    func onMenuItemselected()
    
}

class MenuItemViewModel : ToDoMenuItemPresentable , ToDoMenuItemViewDelegate {
    
    func onMenuItemselected() {
        //base class does not have implementation.
    }
    
    
    var title: String
    var color: String
    
    var parent : ToDoItemSelectedDelegate?
    
    init(title : String, color : String, parentViewModel : ToDoItemSelectedDelegate? ) {
        self.parent = parentViewModel
        self.title = title
        self.color = color
        
    }
}

class RemoveMenuItemViewModel : MenuItemViewModel{
    
    override func onMenuItemselected() {
        print("remove menu Item selected.")
        self.parent?.didSelectRemoveItem()
        
    }
    
}

class DoneMenuItemViewModel : MenuItemViewModel{
    override func onMenuItemselected() {
        print("Done Menu Item Selected.")
        self.parent?.didSelectDoneItem()
    }
    
}

class ToDoItemViewModel : ToDoItemPresentable{
    
    var isDone: Bool?
    var id: String?
    var todoTitle: String?
    var todoDescription: String?
    
    var menuItems : [MenuItemViewModel] = []
    
    var parent : ToDoViewDelegate?
    
    init(_ id : String?,_ todoTitle : String?, _ todoDescription : String?,parentViewModel : ToDoViewDelegate?) {
        self.id = id
        self.todoTitle = todoTitle
        self.todoDescription = todoDescription
        
        self.parent = parentViewModel
        
        let removeMenu = RemoveMenuItemViewModel(title: "Remove", color: "#FF0000",parentViewModel: self)
        let doneMenu = DoneMenuItemViewModel(title: isDone ?? false ? "UnDone":"Done", color: "#006400",parentViewModel: self)
        
        menuItems.append(contentsOf: [removeMenu,doneMenu])
        
    }
    
}

protocol ToDoViewDelegate {
    
    func onCreateNewToDo(title : String?, description : String?) -> (Void)
    func onDeleteToDoItem(todoId : String) -> ()
    func onDoneToDoItem(todoId : String) -> (Void)
}

class ToDoViewModel : ToDoViewDelegate{
    
    static var shared = ToDoViewModel()
    
     var vc : ToDoView?
    
    var toDoList : [ToDoItemViewModel]? = [ToDoItemViewModel]()
    
    init() {
       
        
        let todo1 = ToDoItemViewModel("1", "Buy", "Buy Some Vegetables.",parentViewModel: self)
        let todo2 = ToDoItemViewModel("2", "Sell", "Sell some share.",parentViewModel: self)
        let todo3 = ToDoItemViewModel("3", "Clean", "Clean my Car",parentViewModel: self)
        
        toDoList?.append(contentsOf: [todo1,todo2,todo3])
        
    }
    
    
    func onCreateNewToDo(title: String?, description: String?) {
        let newToDo = ToDoItemViewModel("\(toDoList!.count+1)", title, description,parentViewModel: self)
        toDoList?.append(newToDo)
        vc?.addNewToDo()
    }
    
    func onDeleteToDoItem(todoId : String) {
        
        guard  let index = self.toDoList?.firstIndex(where: {$0.id == todoId}) else {
            return
        }
        self.toDoList?.remove(at: index)
        vc?.removeToDoItem(at: index)
    }
    
    func onDoneToDoItem(todoId : String) {
        guard  let index = self.toDoList?.firstIndex(where: {$0.id == todoId}) else {
            return
        }
        self.toDoList?[index].isDone = !(self.toDoList?[index].isDone ?? false)
        vc?.markDoneToDoItem(at: index)
    }
    
    func getToDosFromNetwork()  {
        print("getting todos from remote api calls")
    }
    
    
    
}

protocol ToDoItemSelectedDelegate {
    
    func didSelectToDoItem()
    func didSelectRemoveItem()
    func didSelectDoneItem()
    
}

extension ToDoItemViewModel : ToDoItemSelectedDelegate{
    func didSelectDoneItem() {
        //
    }
    
    
    func didSelectRemoveItem() {
        self.parent?.onDeleteToDoItem(todoId: self.id!)
    }
    
    func didSelectToDoItem() {
        print("Selected item id : \(self.id) and Title : \(self.todoTitle)")
    }
}
