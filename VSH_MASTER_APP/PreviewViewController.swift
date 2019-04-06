//
//  PreviewViewController.swift
//  VSH_MASTER_APP
//
//  Created by ANDREW STUDENIC on 3/28/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage


class PreviewViewController: UIViewController {

    
    var pvCatchObj = PFObject(className:"Stops")
    
    @IBOutlet weak var stopNameLabel: UILabel!
    
    @IBOutlet weak var imageCollectedLabel: UILabel!
    @IBOutlet weak var coordsCollectedLabel: UILabel!
    
    
    @IBOutlet weak var bioTextfield: UITextField!
    
    @IBOutlet weak var pointsTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        stopNameLabel.text = pvCatchObj["stopName"] as? String
        
        //print(pvCatchObj["stopCoords"])
        
        if pvCatchObj["stopImg"] != nil {
            imageCollectedLabel.text = "Yes"
        }
        print(pvCatchObj["stopCoords"])
        if pvCatchObj["stopCoords"] != nil {
            coordsCollectedLabel.text = "Yes"
        }

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onConfirm(_ sender: Any) {
        
        pvCatchObj["stopBio"] = bioTextfield.text
        
        pvCatchObj["stopPointVal"] = pointsTextfield.text as? Int
        
        pvCatchObj.saveInBackground { (success, error) in
            if success {
                print("saved!")
            } else {
                print("error saving...")
            }
        }
        
        
        
        
        
        self.performSegue(withIdentifier: "previewToHuntSegue", sender: self)
        
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
