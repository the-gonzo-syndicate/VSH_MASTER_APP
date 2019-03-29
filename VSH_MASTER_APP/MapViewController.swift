//
//  MapViewController.swift
//  VSH_MASTER_APP
//
//  Created by ANDREW STUDENIC on 3/28/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Parse

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onCaptureGeo(_ sender: Any) {
        self.performSegue(withIdentifier: "mapToPreviewSegue", sender: self)
        
    }
    
    
    @IBAction func onBack(_ sender: Any) {
        self.performSegue(withIdentifier: "mapToCollectionSegue", sender: self)
        
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
