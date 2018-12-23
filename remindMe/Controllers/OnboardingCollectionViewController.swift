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
        Page(imageName: "logo", header: "Welcome to Remindme", description: "Remindme let's you group all your location-triggered reminders in one place, at all time."),
        
        Page(imageName: "home_page", header: "Groups", description: "Categorize your reminders into groups based on their locations. Click the + button to add a group."),
        
        Page(imageName: "reminder_list", header: "Reminders", description: "Create your reminders under groups, marked as entry or exit with time constraints. Click the + button to add a reminder."),
        
        Page(imageName: "notifications", header: "Get Notified", description: "Receive notifications reminder when you enter or exit a group's location within 65 feet.")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.isPagingEnabled =  true
        self.collectionView!.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: Constant.onboardingViewCellIdentifier)
        setUpButtonControls()
    }
    
    // creates and styles the button to go backward
    let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SKIP", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handleSkipButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // creates and styles the button to go foward
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleNextSwipe), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // creates and lays out the page controller
    lazy var pageControll: UIPageControl = {
        let pageController = UIPageControl()
        pageController.currentPage = 0
        pageController.numberOfPages = pages.count
        pageController.currentPageIndicatorTintColor = .gloomyBlue
        pageController.pageIndicatorTintColor = .gray
        return pageController
    }()
    
    /// Swipes to the next page on the onboarding page
    @objc private func handleNextSwipe(){
        
        let nextIndex = min(pageControll.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControll.currentPage = nextIndex
        collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    /// Shows the user the signin page if onboarding is skipped
    @objc private func handleSkipButton(){
        
        let destinationVC = SignInViewController()
        AppDelegate.shared.window?.rootViewController = destinationVC
        AppDelegate.shared.window?.makeKeyAndVisible()
        
    }
    
    /// Configures and layout the skip, next button and the UIPager element
    private func setUpButtonControls(){
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [skipButton, pageControll, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.axis = .horizontal
        bottomControlsStackView.distribution = .fillEqually
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.onboardingViewCellIdentifier, for: indexPath) as! OnboardingCollectionViewCell
        let page = pages[indexPath.row]
        cell.page = page
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return  0
    }

}
