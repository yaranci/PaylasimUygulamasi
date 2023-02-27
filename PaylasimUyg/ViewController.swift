//
//  ViewController.swift
//  PaylasimUygulamasi
//
//  Created by imrahor on 8.02.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var labelField: UILabel!
    @IBOutlet weak var isimTextField: UITextField!
    @IBOutlet weak var sifreTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func girisTiklandi(_ sender: Any) {
        if isimTextField.text != "" && sifreTextField.text != "" {
            Auth.auth().signIn(withEmail: isimTextField.text!, password: sifreTextField.text!) { authdataResult, error in
                if error != nil {
                    self.hatamesaji(titleInput: "HATA", messageInput: error?.localizedDescription ?? "Hatalı kullanıcı adı veya parola!")
                } else {
                    self.performSegue(withIdentifier:"toFeedVC", sender: nil)
                }
            }
            
        }else {
            hatamesaji(titleInput: "Hata", messageInput: "Lütfen kullanıcı adı ve parola giriniz!")
        }
    }
    
    
    
    @IBAction func kayitTiklandi(_ sender: Any) {
        if isimTextField.text != "" && sifreTextField.text != "" {
            Auth.auth().createUser(withEmail: isimTextField.text!, password: sifreTextField.text!) { authdataResult, error in
                if error != nil {
                    self.hatamesaji(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata aldınız,tekrar deneyin")
                } else {
                    self.performSegue(withIdentifier:"toFeedVC", sender: nil)
                }
            }
        } else {
            hatamesaji(titleInput: "Hata!", messageInput: "Kullanıcı adı ve şifre giriniz")
        }
    }
        
    func hatamesaji(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(button)
        self.present(alert, animated: true)
    }
    
    
}

