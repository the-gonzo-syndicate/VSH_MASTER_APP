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

    var dcCatchObj = PFObject(className:"Stops")
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
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
        }
    }
}
