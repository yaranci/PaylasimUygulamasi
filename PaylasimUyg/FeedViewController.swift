//
//  FeedViewController.swift
//  PaylasimUygulamasi
//
//  Created by imrahor on 8.02.2023.
//

import UIKit
import FirebaseFirestore
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var postDizisi = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        firebaseVerileriAl()
        // Do any additional setup after loading the view.
    }
    
    func firebaseVerileriAl() {
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection("Post").order(by: "tarih", descending: true).addSnapshotListener { snapshot, error in
            
            if error != nil {
                print(error?.localizedDescription)
            }else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.postDizisi.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        if let gorselURL = document.get("gorselUrl") as? String {
                            if let yorum = document.get("yorum") as? String {
                                if let email = document.get("email") as? String {
                                  let post = Post(gorselUrl: gorselURL, yorum: yorum, email: email)
                                    self.postDizisi.append(post)
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                    
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDizisi.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.emaiiText.text = postDizisi[indexPath.row].email
        cell.yorumText.text = postDizisi[indexPath.row].yorum
        //cell.tabImageView.image = UIImage(named: "gorselSec")
        cell.tabImageView.sd_setImage(with: URL(string: self.postDizisi[indexPath.row].gorselUrl))
        return cell
    }
}
