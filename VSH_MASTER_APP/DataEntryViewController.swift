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
    
    var selectedHunt: String?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        huntPicker.delegate = self
        huntPicker.dataSource = self
        huntPicker.setValue(UIColor.white, forKey: "textColor")
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
        
        
        //huntPicker.setValue(UIColor.white, forKey: "textColor")
        selectedHunt = hunts[row]["huntName"] as? String
        
        return hunts[row]["huntName"] as? String
    }
    
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    if segue.destination is DataEntry2ViewController {
    //        let searchedHunt = segue.destination as? DataEntry2ViewController
    //        searchedHunt.name = hunts[row]["huntName"] as? String
    //    }
    //}
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedHunt = hunts[row]["huntName"] as? String
    }
    
    
    @IBAction func onSelect(_ sender: Any) {
        
        self.performSegue(withIdentifier: "huntToStopSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! DataEntry2ViewController
        vc.huntNameSelection = selectedHunt!
        
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
