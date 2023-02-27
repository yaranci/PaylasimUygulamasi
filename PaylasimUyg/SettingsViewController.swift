//
//  SettingsViewController.swift
//  PaylasimUygulamasi
//
//  Created by imrahor on 8.02.2023.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cikisTiklandi(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toVC", sender: nil)
        } catch {
            print("hata")
        }
    }
    

}
