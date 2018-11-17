//
//  GroupListTableViewCell.swift
//  remindMe
//
//  Created by Medi Assumani on 9/18/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class GroupListTableViewCell: UITableViewCell {



    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //- MARK:  Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    
    open var groupNameLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        //label.font = UIFont.boldSystemFont(ofSize: 20)aa
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    open var groupDescriptionLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .lightGray
        //label.font = UIFont.boldSystemFont(ofSize: 15)
        label.font = UIFont(name:"Rockwell", size: 15.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    open var remindersAmountLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    open var lefViewPadder: UIView = {
        
        let view = UIView()
        view.backgroundColor = .blue
        
        return view
    }()


    fileprivate func setUpViews(){
        
        
        // Adds each subview within the root view
        addSubview(groupNameLabel)
        addSubview(groupDescriptionLabel)
        addSubview(remindersAmountLabel)
        
        
        
        // sets up the anchoring constraint for the thumbnail
        groupNameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: groupDescriptionLabel.topAnchor, right: nil, paddingTop: 5, paddingLeft: 15, paddingBottom: 10, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        
        // sets up the anchoring constraint for the name of the space
        groupDescriptionLabel.anchor(top: groupNameLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 10, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        // sets up the anchoring constraint for the price of the place
        remindersAmountLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 10, paddingRight: 10, width: 0, height: 0, enableInsets: false)
    }
    
}
