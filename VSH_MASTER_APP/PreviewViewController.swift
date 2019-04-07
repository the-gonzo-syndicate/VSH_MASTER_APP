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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        stopNameLabel.text = pvCatchObj["stopName"] as? String
        
        if pvCatchObj["stopImg"] != nil { // THESE ARE NOT WORKING
            imageCollectedLabel.text = "Yes"
        }

        if pvCatchObj["stopCoords"] != nil {
            coordsCollectedLabel.text = "Yes"
        }
    }
    
    @IBAction func onConfirm(_ sender: Any) {
        
        pvCatchObj["stopBio"] = bioTextfield.text
        
        pvCatchObj["stopPointVal"] = 5
        
        pvCatchObj.saveInBackground { (success, error) in
            if success {
                print("saved!")
            } else {
                print("error saving...")
            }
        }
        
        self.performSegue(withIdentifier: "previewToHuntSegue", sender: self)
        
    }
}
