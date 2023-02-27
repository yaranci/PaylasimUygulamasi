//
//  UploadViewController.swift
//  PaylasimUygulamasi
//
//  Created by imrahor on 8.02.2023.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(gestureRecognizer)
        // Do any additional setup after loading the view.
    }
    
    @objc func gorselSec(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func uploadTiklandi(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
        
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            
            imageReference.putData(data, metadata: nil) { storagemetadata, error in
                if error != nil {
                    self.hataMesajiGoster(title: "Hata", message: error?.localizedDescription ?? "Hata oldu tekrar gir")
                } else{
                    imageReference.downloadURL { url, error in
                        let imageUrl = url?.absoluteString
                        if let imageURL = imageUrl {
                            let firestoreDatabase = Firestore.firestore()
                            let firestorePost = ["gorselUrl" : imageURL,
                                                 "yorum" : self.textField.text!,
                                                 "email" : Auth.auth().currentUser!.email ?? "",
                                                 "tarih" : FieldValue.serverTimestamp()] as [String : Any]
                            firestoreDatabase.collection("Post").addDocument(data: firestorePost) { error in
                                if error != nil {
                                    self.hataMesajiGoster(title: "Hata", message: error?.localizedDescription ?? "Tekrar upload etmeyi deneyin.")
                                } else{
                                    self.imageView.image = UIImage(named: "gorselSec")
                                    self.textField.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            }
                            
                        }
                    }
                }
                
            }
            
        }
    }
    
    func hataMesajiGoster(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
    
}
