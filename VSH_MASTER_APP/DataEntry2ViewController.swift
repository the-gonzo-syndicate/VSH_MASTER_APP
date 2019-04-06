//
//  DataEntry2ViewController.swift
//  VSH_MASTER_APP
//
//  Created by Andrew on 3/26/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Parse

class DataEntry2ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var stops = [PFObject]()
    
    var selectedStop: String?
    //var selectedStop: PFObject!
    
    var de2ThrowObj = PFObject(className:"Stops")
    
    var huntNameSelection = ""
    
    @IBOutlet weak var stopPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopPickerView.delegate = self
        stopPickerView.dataSource = self
        
        

        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Stops")
        query.whereKey("inHunt", equalTo: huntNameSelection)
        query.findObjectsInBackground { (stops, error) in
            
            if stops != nil {
                self.stops = stops!
                self.stopPickerView.reloadAllComponents()
                print(stops)
            }
            self.stopPickerView.reloadAllComponents()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stops.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        stopPickerView.setValue(UIColor.white, forKey: "textColor")
        selectedStop = stops[row]["stopName"] as? String
        //de2ThrowObj = stops[row]["stopName"] as? String
        
        return stops[row]["stopName"] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //selectedStop = stops[row] as! PFObject
        de2ThrowObj = stops[row] //as! PFObject  WORKING HERE
        //print(selectedStop ?? "error 2 view")
    }
    
    @IBAction func onSelect(_ sender: Any) {
        self.performSegue(withIdentifier: "stopToCaptureSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is DataCollectionViewController){
            let vc = segue.destination as! DataCollectionViewController
            vc.dcCatchObj = de2ThrowObj
            //print(selectedStop ?? "error 2 view")
        }
    }
    
    
    @IBAction func onBack(_ sender: Any) {
        self.performSegue(withIdentifier: "stopToHuntSegue", sender: self)
        
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
