//
//  OnboardingCollectionViewCell.swift
//  remindMe
//
//  Created by Medi Assumani on 12/21/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    var page: Page?{
        didSet{
            
            guard let unwrappedPage = page else {return}
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.header, attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 18)])
            
            attributedText.append(NSAttributedString(string: "\n\n\n\(unwrappedPage.description)", attributes:
                [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                 NSAttributedString.Key.foregroundColor: UIColor.gray]))
            
            pageImageView.image = UIImage(named: unwrappedPage.imageName)
            pageDescriptionTextView.attributedText = attributedText
            pageDescriptionTextView.textAlignment = .center
        }
    }
    
    private let pageImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: ""))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.shadowRadius = 1
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let pageDescriptionTextView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "",
                                                       attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSAttributedString(string: "", attributes:
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
             NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        layoutElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Lays out all UI Components in the cell with AutoLayout
    private func layoutElements(){
     
        let pageImageViewContainer = UIView()
        
        addSubview(pageImageView)
        addSubview(pageImageViewContainer)
        addSubview(pageDescriptionTextView)
        
        pageImageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        pageImageViewContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        pageImageViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        pageImageViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        pageImageViewContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        
        pageImageView.centerXAnchor.constraint(equalTo: pageImageViewContainer.centerXAnchor).isActive = true
        pageImageView.centerYAnchor.constraint(equalTo: pageImageViewContainer.centerYAnchor).isActive = true
        pageImageView.heightAnchor.constraint(equalTo: pageImageViewContainer.heightAnchor, multiplier: 0.5).isActive = true
        pageImageView.widthAnchor.constraint(equalTo: pageImageViewContainer.widthAnchor, multiplier: 0.5).isActive = true
        
        pageDescriptionTextView.topAnchor.constraint(equalTo: pageImageViewContainer.bottomAnchor).isActive = true
        pageDescriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        pageDescriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        pageDescriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
}
