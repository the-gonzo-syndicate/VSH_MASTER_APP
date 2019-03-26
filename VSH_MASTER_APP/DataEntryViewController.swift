//
//  DataEntryViewController.swift
//  VSH_MASTER_APP
//
//  Created by Andrew on 3/24/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Parse

class DataEntryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    
    
    @IBOutlet weak var huntPicker: UIPickerView!
    
    var hunts = [PFObject]()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        huntPicker.delegate = self
        huntPicker.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Hunt")
        query.includeKeys(["huntName"])
        query.findObjectsInBackground { (hunts, error) in
            
            if hunts != nil {
                self.hunts = hunts!
                self.huntPicker.reloadAllComponents()
                print(hunts)
            }
            self.huntPicker.reloadAllComponents()
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hunts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        //var huntTitles = [String]()
        
        
        
        //let huntTitle = hunts.huntName[row] as? String
        
        return "blah" //self.hunts[row]
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
