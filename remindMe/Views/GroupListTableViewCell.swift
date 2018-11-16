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
    
    private let groupNameLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let groupDescriptionLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let remindersAmountLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    fileprivate func setUpViews(){
        
        
        // Adds each subview within the root view
        addSubview(groupNameLabel)
        addSubview(groupDescriptionLabel)
        addSubview(remindersAmountLabel)
        
        // sets up the anchoring constraint for the thumbnail
        groupNameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        
        // sets up the anchoring constraint for the name of the space
        groupDescriptionLabel.anchor(top: groupNameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        
        // sets up the anchoring constraint for the price of the place
        remindersAmountLabel.anchor(top: topAnchor, left: groupNameLabel.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 10, width: frame.size.width / 2, height: 0, enableInsets: false)
    }
    
}
