//
//  DataCollectionViewController.swift
//  VSH_MASTER_APP
//
//  Created by Andrew on 3/26/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class DataCollectionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    
    //var stopNameSelection = ""
    //var stopNameSelection = PFObject()
    var dcCatchObj = PFObject(className:"Stops")
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    //@IBAction func onPreview(_ sender: Any) {
    //    self.performSegue(withIdentifier: "captureToPreviewSegue", sender: self)
    //}
    
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onBack(_ sender: Any) {
        
        self.performSegue(withIdentifier: "captureToStopSegue", sender: self)
        
    }
    
    
    
    @IBAction func onSelect(_ sender: Any) {
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        dcCatchObj["stopImg"] = file
        
        
        self.performSegue(withIdentifier: "captureToMapSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is MapViewController){
            let vc = segue.destination as! MapViewController
            vc.mvCatchObj = dcCatchObj
            //print(stopNameSelection ?? "error 2 view")
        }
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
