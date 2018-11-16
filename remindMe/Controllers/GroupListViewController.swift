//
//  GroupListViewController.swift
//  remindMe
//
//  Created by Medi Assumani on 9/18/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//


import Foundation
import UIKit

class GroupListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
// This View Controller class handles functionality to show the list of all the groups

    var remindersDataStackView = UIStackView()
    var totalRemindersStackView = UIStackView()
    var totalRemindersOnEntryStackView = UIStackView()
    var totalRemindersOnExitStackView = UIStackView()
    var totalRemindersBox = UIView()
    var totalRemindersOnEntryBox =  UIView()
    var totalRemindersOnExitBox = UIView()
    var totalReminderAmountLabel = UILabel()
    var totalReminderTextView = UITextView()
    var totalRemindersOnEntryAmountLable = UILabel()
    var totalRemindersOnEntryTextView = UITextView()
    var totalRemindersOnExitAmountLable = UILabel()
    var totalRemindersOnExitTextView = UITextView()
    //var totalRemindersOnExitBox = UIView()
    //var mainStackView = UIStackView()
    //var reminderDataStackView = UIStackView()
//    var tableViewStackView = UIStackView()
    
    

//    static var numberOfReminders = 0
//    let networkManager = NetworkManager.shared
//    var userGroups = [Group](){
//        didSet {
//            DispatchQueue.main.async {
//                self.groupTableView.reloadData()
//            }
//        }
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupListTableView.register(GroupListTableViewCell.self, forCellReuseIdentifier: Constant.groupTableViewCellIdentifier)

        self.view.backgroundColor = .white
        createRectangularViews()
        createCustomRemindersLabels()
        view.addSubview(remindersContainer)
        setUpRemindersDataContainer()
        setUpRemindersDataStackView()
        setUpTotalRemindersStackView()
        setUpEntriesReminderStackView()
        setUpExitReminderStackView()

        
        
        
//        fetchAllGroups()
//        monitorReminders()
//
//        networkManager.reachability.whenUnreachable = { reachability in
//            self.showOfflinePage()
//        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        DispatchQueue.main.async {
//            self.groupTableView.reloadData()
//        }
    }
    
    
//    fileprivate func showOfflinePage(){
//        DispatchQueue.main.async {
//            self.performSegue(withIdentifier: Constant.offlinePageSegueIdentifier, sender: self)
//        }
//    }
//    // This Method makes a client side request to the server to get all groups
//    internal func fetchAllGroups(){
//        GroupServices.index(completion: { (groups) in
//            self.userGroups = groups!
//        })
//    }
    
//    fileprivate func monitorReminders(){
//        ReminderServices.index { (reminders) in
//            guard let reminders = reminders else {return}
//            GeoFence.shared.startMonitor(reminders, completion: { (true) in
//                print("Start Monitoring")
//            })
//        }
//    }
//
    // This method is used to go back to the group of list view controller
//    @IBAction func unwindtoGroupListViewController(_ segue: UIStoryboardSegue){
//        fetchAllGroups()
//    }
    
    
    
        // - MARK: UI ELEMENTS AND METHODS
    
    
    /// The light cyan colored rectangular container that holds the reminders boxes
    private let remindersContainer: UIView = {
        
        let view = UIView()
        view.backgroundColor = .lightCyan
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.shadowRadius = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// The table view that will contains the list og groups
    private let groupListTableView: UITableView = {

        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    
    // sets up home page title and nav bar items
    fileprivate func setUpNavigationBarItems(){
        
        let titleLabel = UILabel()
        let addIconButton = UIButton(type: .system)
        
        titleLabel.text = "My Groups"
        addIconButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        addIconButton.setImage(UIImage(named: "bar_item_5"), for: .normal)
        addIconButton.contentMode = .scaleToFill

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addIconButton)
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
    
    }
    
    fileprivate func createRectangularViews(){
        
        totalRemindersBox = makeCustomReminderBox(bColor: .white, borderWidth: 1.0, borderColor: UIColor.lightBlue.cgColor, cornerRadius: 15, clipsToBound: true, maskToBounds: true, shadowRadius: 1)
        
        totalRemindersOnEntryBox = makeCustomReminderBox(bColor: .white, borderWidth: 1.0, borderColor: UIColor.lightBlue.cgColor, cornerRadius: 15, clipsToBound: true, maskToBounds: true, shadowRadius: 1)
        
        totalRemindersOnExitBox = makeCustomReminderBox(bColor: .white, borderWidth: 1.0, borderColor: UIColor.lightBlue.cgColor, cornerRadius: 15, clipsToBound: true, maskToBounds: true, shadowRadius: 1)
    }
    
    fileprivate func createCustomRemindersLabels(){
        
        let customTotaReminderslLabelsTuple = makeCustomReminderLabels(labelText: "40", labelColor: UIColor.black, textViewBody: "Total Reminders", textViewSize: 12, textViewBodyColor: UIColor.gray)
        
        let customEntryRemindersLabelsTuple = makeCustomReminderLabels(labelText: "10", labelColor: UIColor.black, textViewBody: "Total on entry", textViewSize: 12, textViewBodyColor: UIColor.gray)
        
        let customExitReminderlLabelsTuple = makeCustomReminderLabels(labelText: "30", labelColor: UIColor.black, textViewBody: "Total on exit", textViewSize: 12, textViewBodyColor: UIColor.gray)
        
        
        
        totalReminderAmountLabel = customTotaReminderslLabelsTuple.0
        totalReminderTextView = customTotaReminderslLabelsTuple.1
        
        totalRemindersOnEntryAmountLable = customEntryRemindersLabelsTuple.0
        totalRemindersOnEntryTextView = customEntryRemindersLabelsTuple.1
        
        totalRemindersOnExitAmountLable = customExitReminderlLabelsTuple.0
        totalRemindersOnExitTextView = customExitReminderlLabelsTuple.1
    }
    
    /// Anchors the light cyan colored rectangular container that holds the reminders boxes
    fileprivate func setUpRemindersDataContainer(){
        
        remindersContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 50, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 300, height: 150, enableInsets: false)
    }
    
    
    /// This functions takes in in properties of a uiview a creates a custom view in form of a box
    fileprivate func makeCustomReminderBox(bColor: UIColor, borderWidth: CGFloat, borderColor: CGColor, cornerRadius: CGFloat, clipsToBound: Bool, maskToBounds: Bool, shadowRadius: CGFloat ) -> UIView{
        
        let customView = UIView()
        customView.backgroundColor = bColor
        customView.layer.borderWidth = borderWidth
        customView.layer.borderColor = borderColor
        customView.layer.cornerRadius = cornerRadius
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }
    
    fileprivate func makeCustomReminderLabels(labelText: String, labelColor: UIColor, textViewBody: String, textViewSize: Int, textViewBodyColor: UIColor) -> (UILabel, UITextView){
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = labelColor
        label.text = labelText
        label.font = UIFont.boldSystemFont(ofSize: 30)
        
        let textview = UITextView()
        let attributedText = NSMutableAttributedString(string: textViewBody,
                                                       attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 12),
                                                                    NSAttributedString.Key.foregroundColor: UIColor.gray])
        textview.attributedText = attributedText
        textview.textAlignment = .center
        textview.isEditable = false
        textview.isScrollEnabled = false
        textview.translatesAutoresizingMaskIntoConstraints = false
        
        return (label,textview)
    }
    
    /// Anchors the stackview that will hold the three reminders squared boxes
    fileprivate func setUpRemindersDataStackView(){
        
        remindersDataStackView = UIStackView(arrangedSubviews: [totalRemindersBox,
                                                                totalRemindersOnEntryBox,
                                                                totalRemindersOnExitBox])
        
        remindersDataStackView.translatesAutoresizingMaskIntoConstraints = false
        remindersDataStackView.alignment = .center
        remindersDataStackView.distribution = .fillEqually
        remindersDataStackView.axis = .horizontal
        remindersContainer.addSubview(remindersDataStackView)
        
        remindersDataStackView.anchor(top: remindersContainer.topAnchor, left: remindersContainer.leftAnchor, bottom: remindersContainer.bottomAnchor, right: remindersContainer.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        
        totalRemindersBox.anchor(top: remindersDataStackView.topAnchor, left: remindersDataStackView.leftAnchor, bottom: remindersDataStackView.bottomAnchor, right: totalRemindersOnEntryBox.leftAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 20, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        
        totalRemindersOnEntryBox.anchor(top: remindersDataStackView.topAnchor, left: totalRemindersBox.rightAnchor, bottom: remindersDataStackView.bottomAnchor, right: totalRemindersOnExitBox.leftAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 20, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        
        totalRemindersOnExitBox.anchor(top: remindersDataStackView.topAnchor, left: totalRemindersOnEntryBox.rightAnchor, bottom: remindersDataStackView.bottomAnchor, right: remindersContainer.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 20, paddingRight: 10, width: 0, height: 0, enableInsets: false)
    }
    
    /// Anchors
    fileprivate func setUpTotalRemindersStackView(){
        
        totalRemindersStackView = UIStackView(arrangedSubviews: [totalReminderAmountLabel,
                                                                 totalReminderTextView])
        
        totalRemindersStackView.translatesAutoresizingMaskIntoConstraints = false
        totalRemindersStackView.alignment = .center
        totalRemindersStackView.axis = .vertical
        totalRemindersStackView.distribution = .fillEqually
        totalRemindersBox.addSubview(totalRemindersStackView)
        
        totalRemindersStackView.anchor(top: totalRemindersBox.topAnchor, left: totalRemindersBox.leftAnchor, bottom: totalRemindersBox.bottomAnchor, right: totalRemindersBox.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        totalReminderAmountLabel.centerXAnchor.constraint(equalTo: totalRemindersBox.centerXAnchor).isActive = true
        totalReminderTextView.centerXAnchor.constraint(equalTo: totalRemindersBox.centerXAnchor).isActive = true
    }
    
    fileprivate func setUpEntriesReminderStackView(){
        
        totalRemindersOnEntryStackView = UIStackView(arrangedSubviews: [totalRemindersOnEntryAmountLable,
                                                                        totalRemindersOnEntryTextView])
        
        totalRemindersOnEntryStackView.translatesAutoresizingMaskIntoConstraints = false
        totalRemindersOnEntryStackView.alignment = .center
        totalRemindersOnEntryStackView.axis = .vertical
        totalRemindersOnEntryStackView.distribution = .fillEqually
        totalRemindersOnEntryBox.addSubview(totalRemindersOnEntryStackView)
        
        totalRemindersOnEntryStackView.anchor(top: totalRemindersOnEntryBox.topAnchor, left: totalRemindersOnEntryBox.leftAnchor, bottom: totalRemindersOnEntryBox.bottomAnchor, right: totalRemindersOnEntryBox.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        
        totalRemindersOnEntryAmountLable.centerXAnchor.constraint(equalTo: totalRemindersOnEntryBox.centerXAnchor).isActive = true
        totalRemindersOnEntryTextView.centerXAnchor.constraint(equalTo: totalRemindersOnEntryBox.centerXAnchor).isActive = true

    }
    
    fileprivate func setUpExitReminderStackView(){
        
        totalRemindersOnExitStackView = UIStackView(arrangedSubviews: [totalRemindersOnExitAmountLable,
                                                                        totalRemindersOnExitTextView])
        
        totalRemindersOnExitStackView.translatesAutoresizingMaskIntoConstraints = false
        totalRemindersOnExitStackView.alignment = .center
        totalRemindersOnExitStackView.axis = .vertical
        totalRemindersOnExitStackView.distribution = .fillEqually
        totalRemindersOnExitBox.addSubview(totalRemindersOnExitStackView)
        
        totalRemindersOnExitStackView.anchor(top: totalRemindersOnExitBox.topAnchor, left: totalRemindersOnExitBox.leftAnchor, bottom: totalRemindersOnExitBox.bottomAnchor, right: totalRemindersOnExitBox.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        
        totalRemindersOnExitAmountLable.centerXAnchor.constraint(equalTo: totalRemindersOnExitBox.centerXAnchor).isActive = true
        totalRemindersOnExitTextView.centerXAnchor.constraint(equalTo: totalRemindersOnExitBox.centerXAnchor).isActive = true
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // This Function handles action when a cell is selected
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let groupCell = tableView.dequeueReusableCell(withIdentifier: Constant.groupTableViewCellIdentifier, for: indexPath) as! GroupListTableViewCell
           
        return groupCell
    }

}
