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

    
    @IBOutlet weak var previewImageView: UIImageView!
    
    @IBOutlet weak var stopNameLabel: UILabel!
    
    @IBOutlet weak var coordsCollectedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onConfirm(_ sender: Any) {
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
