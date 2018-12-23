//
//  Page.swift
//  remindMe
//
//  Created by Medi Assumani on 12/22/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

/*
    The Page Strutc models each page on the onboarding screen
    Properties:
         - imageName : the file name of the image to be displayed on the page
         - header : the short header text to be displayed on the page
         - description : the description to be displayed on the page
 **/

struct Page{
    
    var imageName: String
    var header: String
    var description: String
    
    init(imageName: String, header: String, description: String) {
        
        self.imageName = imageName
        self.header = header
        self.description = description
    }
}
