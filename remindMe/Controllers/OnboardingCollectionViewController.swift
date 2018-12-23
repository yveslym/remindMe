//
//  OnboardingCollectionViewController.swift
//  remindMe
//
//  Created by Medi Assumani on 12/21/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class OnboardingCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let pages = [
        Page(imageName: "logo", header: "Welcome to Remindme", description: "Remindme let's you group all your location-triggered reminders in one place, at all time"),
        
        Page(imageName: "logo", header: "Welcome to Remindme", description: "Remindme let's you group all your location-triggered reminders in one place, at all time"),
        Page(imageName: "logo", header: "Welcome to Remindme", description: "Remindme let's you group all your location-triggered reminders in one place, at all time"),
        Page(imageName: "logo", header: "Welcome to Remindme", description: "Remindme let's you group all your location-triggered reminders in one place, at all time"),
    
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: Constant.onboardingViewCellIdentifier)
        collectionView?.backgroundColor = .green

    }


    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.onboardingViewCellIdentifier, for: indexPath) as! OnboardingCollectionViewCell
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return  0
    }

}
