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
        label.textColor = .lightDark
        //label.font = UIFont.boldSystemFont(ofSize: 20)aa
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    open var groupDescriptionLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .gray
        //label.font = UIFont.boldSystemFont(ofSize: 15)
        label.font = UIFont(name:"HelveticaNeue-Light", size: 15.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    open var remindersAmountLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Light", size: 20)
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
        groupNameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: groupDescriptionLabel.topAnchor, right: nil, paddingTop: 10, paddingLeft: 15, paddingBottom: 10, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        groupNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        groupNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1)
        
        // sets up the anchoring constraint for the name of the space
        groupDescriptionLabel.anchor(top: groupNameLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 10, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        groupDescriptionLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        groupDescriptionLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1)
        
        // sets up the anchoring constraint for the price of the place
        remindersAmountLabel.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 20, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        remindersAmountLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        remindersAmountLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1)
    }
    
}
