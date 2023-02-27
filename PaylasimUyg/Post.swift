//
//  Post.swift
//  PaylasimUyg
//
//  Created by imrahor on 12.02.2023.
//

import Foundation

class Post {
    var gorselUrl : String
    var yorum : String
    var email : String
    
    init(gorselUrl : String, yorum : String, email : String) {
        self.gorselUrl = gorselUrl
        self.yorum = yorum
        self.email = email
    }
}
