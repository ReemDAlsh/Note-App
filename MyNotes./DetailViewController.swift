//
//  DetailViewController.swift
//  MyNotes.
//
//  Created by Reem alsharif on 9/11/17.
//  Copyright © 2017 Reem alsharif. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var viewText: UITextView!
    var text:String = ""
    var masterView: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewText.text = text
        self.title = "notes"
        
    }
  
    // to write text - لكتبت النص 
    func setText(t:String){
        
        text = t
        if isViewLoaded{
            
            viewText.text = t
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        masterView.newRowText = viewText.text
        
    }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


