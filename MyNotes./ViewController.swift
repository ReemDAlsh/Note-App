//
//  ViewController.swift
//  MyNotes.
//
//  Created by Reem alsharif on 9/10/17.
//  Copyright © 2017 Reem alsharif. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var table: UITableView!
    var myData: [String] = []
    var selectedRow: Int = -1
    var newRowText:String = ""
    var detailView: DetailViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "My Notes"
        // we will create a buttons to add new notes - زرار لاضافة ملاحظة جديدة 
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddNewNotes))
        self.navigationItem.rightBarButtonItem = addButton
        // here we will add delete button - الان سوف نكتب كود لزرار الحذف او تعديل 
        self.navigationItem.leftBarButtonItem = editButtonItem
        load()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if selectedRow == -1 {
            return
        }
        myData[selectedRow] = newRowText
        if newRowText == "" {
            myData.remove(at: selectedRow)
        }
        table.reloadData()
        save()
    }

    
    //now we gonna learn how to add new notes - الان سنتعلم كيف نضيف ملاحظة جديدة
    func AddNewNotes(){
        // to prevent add new note while editing mode - لمنع الاضافة في مود التعديل
        if table.isEditing{
            return
        }
        
        let name:String = ""
        myData.insert(name, at: 0)
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        table.insertRows(at: [indexPath], with: .automatic)
        table.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        self.performSegue(withIdentifier: "detail", sender: nil )
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = myData[indexPath.row]
        return cell
        
    }
    
    
    //Editing - للتعديل 
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        myData.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .fade)
        
        save()
    }
    
    //How to select a row - كيفية اختياري الصف
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detail", sender: nil )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailView:DetailViewController = segue.destination as!DetailViewController
        selectedRow = table.indexPathForSelectedRow!.row
        detailView.masterView = self
        detailView.setText(t: myData[selectedRow])
    }
    
    
    // how to save these notes ?  كيف نحفظ الملاحظات 
    func save() {
        
    UserDefaults.standard.set(myData, forKey: "notes")
    UserDefaults.standard.synchronize()
        
    }
    
    
    func load(){
        if let loadData = UserDefaults.standard.value(forKey: "notes") as? [String] {
            
            myData = loadData
            table.reloadData()
            
        }
        
    }
    

    
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

