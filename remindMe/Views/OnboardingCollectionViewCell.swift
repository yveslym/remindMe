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
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.header, attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 23)])
            
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
        return imageView
    }()
    
    private let pageDescriptionTextView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "",
                                                       attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 23)])
        
        attributedText.append(NSAttributedString(string: "", attributes:
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
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
     
        let stack = CustomStack(subview: [pageImageView, pageDescriptionTextView],
                                alignment: .center,
                                axis: .vertical,
                                distribution: .fill)
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([stack.topAnchor.constraint(equalTo: topAnchor, constant: 30),
                                     stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                                     stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                                     stack.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     stack.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     pageImageView.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.7),
                                     pageImageView.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.7),
                                     pageDescriptionTextView.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.3),
                                     pageDescriptionTextView.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.8)])
    }
}
