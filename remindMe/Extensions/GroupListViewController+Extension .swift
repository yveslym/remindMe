//
//  GroupListViewController+Extension .swift
//  remindMe
//
//  Created by Medi Assumani on 9/18/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

extension GroupListViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    // - MARK: UITableView Delegate Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userGroups.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let groupCell = tableView.dequeueReusableCell(withIdentifier: Constant.groupTableViewCellIdentifier, for: indexPath) as! GroupListTableViewCell
        
        let customView = CustomView(frame: groupCell.contentView.frame, leftViewColor: #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1))
        groupCell.contentView.addSubview(customView)
        customView.anchor(top: groupCell.contentView.topAnchor,
                          left:  groupCell.contentView.leftAnchor,
                          bottom:  groupCell.contentView.bottomAnchor,
                          right:  groupCell.contentView.rightAnchor,
                          paddingTop: 5,
                          paddingLeft: 0,
                          paddingBottom:5,
                          paddingRight: 0,
                          width: 0,
                          height: 5,
                          enableInsets: true)
        groupCell.backgroundColor = .lightCyan
        
        let currentGroup = userGroups[indexPath.row]
        let counter = userReminders.filter({$0.groupId == currentGroup.id}).count
        
        groupCell.groupNameLabel.text = currentGroup.name
        groupCell.groupDescriptionLabel.text = currentGroup.description
        groupCell.remindersAmountLabel.text = counter.convertIntToString()
        

        return groupCell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = deleteAction(at: indexPath)
        let update = updateAtcion(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [delete, update])
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let group = userGroups[indexPath.row]
        let destinationVC = ReminderListViewController()
        destinationVC.userReminders = userReminders.filter({$0.groupId == group.id})
        destinationVC.userGroup = userGroups[indexPath.row]
        self.navigationController?.pushViewController(destinationVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 85
    }
    
    // MARK: Helper Class Methods
    
    /// Return an action to delete a Group object on the tableview row
    fileprivate func deleteAction(at indexPath: IndexPath) -> UIContextualAction{
        
        let groupToBeDeleted = userGroups[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            GroupServices.delete(group: groupToBeDeleted)
            completion(true)
        }
        
        deleteAction.title = "Delete"
        deleteAction.backgroundColor = .red
        
        return deleteAction
    }
    
    /// Return an action to upadte a Group obejct on the tableview row
    fileprivate func updateAtcion(at indexPath: IndexPath) -> UIContextualAction{
        
        let groupToBeUpdated = userGroups[indexPath.row]
        let updateAction = UIContextualAction(style: .normal, title: "Update") { (action, view, completion) in
            
            let destinationVC = CreateGroupViewController()
            destinationVC.group = groupToBeUpdated
            destinationVC.modalTransitionStyle = .crossDissolve
            destinationVC.modalPresentationStyle = .overCurrentContext
            self.present(destinationVC, animated: true, completion: nil)
            completion(true)
        }
        
        updateAction.title = "Update"
        updateAction.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1)
        
        return updateAction
    }
    

    
    // - MARK: Helper AutoLayout Methods
    
    
    /// Adds the view on top of the root view of the view controller
    func addViews(){
        view.addSubview(remindersContainer)
        view.addSubview(tableViewContainer)
        view.addSubview(tableViewTitle)
    }
    
    
    /// Instanciates three UIViews variables of box shape that are placed on top of the home page
    func createRectangularViews(){
        
        totalRemindersBox = makeCustomReminderBox(bColor: .white, borderWidth: 1.0, borderColor: UIColor.lightBlue.cgColor, cornerRadius: 15, clipsToBound: true, maskToBounds: true, shadowRadius: 1)
        
        totalRemindersOnEntryBox = makeCustomReminderBox(bColor: .white, borderWidth: 1.0, borderColor: UIColor.gloomyGreen.cgColor, cornerRadius: 15, clipsToBound: true, maskToBounds: true, shadowRadius: 1)
        
        totalRemindersOnExitBox = makeCustomReminderBox(bColor: .white, borderWidth: 1.0, borderColor: UIColor.gloomyYellow.cgColor, cornerRadius: 15, clipsToBound: true, maskToBounds: true, shadowRadius: 1)
    }
    
    /// Instanciate the labels that go inside the reminder data boxes on top of the home page
    func createCustomRemindersLabels(){
        
        let customTotaReminderslLabelsTuple = makeCustomReminderLabels(labelText: "0", labelColor: UIColor.black, textViewBody: "Total Reminders", textViewSize: 12, textViewBodyColor: UIColor.gray)
        
        let customEntryRemindersLabelsTuple = makeCustomReminderLabels(labelText: "0", labelColor: UIColor.black, textViewBody: "Total on entry", textViewSize: 12, textViewBodyColor: UIColor.gray)
        
        let customExitReminderlLabelsTuple = makeCustomReminderLabels(labelText: "0", labelColor: UIColor.black, textViewBody: "Total on exit", textViewSize: 12, textViewBodyColor: UIColor.gray)
        
        
        totalReminderAmountLabel = customTotaReminderslLabelsTuple.0
        totalReminderTextView = customTotaReminderslLabelsTuple.1
        
        totalRemindersOnEntryAmountLable = customEntryRemindersLabelsTuple.0
        totalRemindersOnEntryTextView = customEntryRemindersLabelsTuple.1
        
        totalRemindersOnExitAmountLable = customExitReminderlLabelsTuple.0
        totalRemindersOnExitTextView = customExitReminderlLabelsTuple.1
    }
    
    
    
    /* Creates a custom view through peroperties passed as parameters
     @param :
     @return
     */
    func makeCustomReminderBox(bColor: UIColor, borderWidth: CGFloat, borderColor: CGColor, cornerRadius: CGFloat, clipsToBound: Bool, maskToBounds: Bool, shadowRadius: CGFloat ) -> UIView{
        
        let customView = UIView()
        customView.backgroundColor = bColor
        customView.layer.borderWidth = borderWidth
        customView.layer.borderColor = borderColor
        customView.layer.cornerRadius = cornerRadius
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }
    
    /* Creates a custom label and textview through peroperties passed as parameters
     @param :
     @return
     */
    func makeCustomReminderLabels(labelText: String, labelColor: UIColor, textViewBody: String, textViewSize: Int, textViewBodyColor: UIColor) -> (UILabel, UITextView){
        
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
    
    
    /// Anchors the light cyan colored rectangular container that holds the 3 reminders boxes
    func anchorRemindersDataContainer(){
        
        remindersContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 300, height: 150, enableInsets: false)
    }
    
    func anchorTableViewTitle(){
        tableViewTitle.anchor(top: remindersContainer.bottomAnchor, left: view.leftAnchor, bottom: tableViewContainer.topAnchor, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 10, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    /// Anchors the outer conatainer view that holds the table view
    func anchorTableViewContainer(){
        
        tableViewContainer.anchor(top: tableViewTitle.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0, enableInsets: false)
    }
    
    
    /// Anchors the stackview that will hold the three reminders squared boxes
    func anchorRemindersDataStackView(){
        
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
    
    /// Anchors the view that holds the total reminders
    func anchorTotalRemindersStackView(){
        
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
    
    /// Anchors the view that holds the reminders on entry
    func anchorEntriesReminderStackView(){
        
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
    
    /// Anchors the view that holds the reminders on exit
    func anchorExitReminderStackView(){
        
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
    
    /// Anchors the table view in the table view container view
    func anchorTableView(){
        
        groupListTableView.register(GroupListTableViewCell.self, forCellReuseIdentifier: Constant.groupTableViewCellIdentifier)
        groupListTableView.separatorStyle = .none
        groupListTableView.delegate = self
        groupListTableView.dataSource = self
        
        tableViewContainer.addSubview(groupListTableView)
        groupListTableView.anchor(top: tableViewContainer.topAnchor, left: tableViewContainer.leftAnchor, bottom: tableViewContainer.bottomAnchor, right: tableViewContainer.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0, enableInsets: false)
    }

}

extension GroupListViewController: GroupDelegate{

    func didRescievedNewNotification(reminder: Reminder) {
        
        GroupServices.show(reminder.groupId) { (group) in
            guard let group = group else {return}
            let alert = UIAlertController.init(title: reminder.name, message: reminder.description! + "\(group.name) reminder" , preferredStyle: .alert)
            let button = UIAlertAction(title: "Done", style: .cancel, handler: nil)
            alert.addAction(button)
            self.present(alert,animated: true)
        }
    }


}
