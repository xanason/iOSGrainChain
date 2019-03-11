//
//  ContactListViewController.swift
//  GrainChain Test
//
//  Created by Tecnocen on 3/6/19.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

class ContactListViewController: UITableViewController, UISearchBarDelegate {
    
    //MARK: IBOutlets
    
    @IBOutlet var tableList: UITableView!
    //MARK: - Variables
    var contactList:[Contact] = Contact.generateModelArray()
    var filteredContact:[Contact] = Contact.generateModelArray()
    var updateContactList:[Contact] = Contact.generateModelArray()
    var index = 0;
    var delete : (()->())?
    var selectedIndex = 0
    var isSearching = false
    var searchController: UISearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.frame.origin = CGPoint(x: 0, y: 55.0)
        extendedLayoutIncludesOpaqueBars = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.deleteContactUpdate(_:)), name: NSNotification.Name.CompleteContactDelete, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.addContactUpdate(_:)), name: NSNotification.Name.addContactUpdate, object: nil)
        let vc =  self.tabBarController as! ContactTabBarViewController
        contactList = vc.contactList
        filteredContact = vc.filteredContact
        searchController = vc.searchController
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
    }
    @objc func loadList(notification: NSNotification){
        //load data here
        self.tableView.reloadData()
    }
    
    @objc func deleteContactUpdate(_ notification: Notification?) {
        delete?()
    }
    @objc func addContactUpdate(_ notification: Notification?) {
        
        contactList.append(contentsOf: updateContactList )
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.frame.origin = CGPoint(x: 0, y: 55.0)
        extendedLayoutIncludesOpaqueBars = true
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.frame.origin = CGPoint(x: 0, y: 55.0)
        extendedLayoutIncludesOpaqueBars = true
        
    }
    
    override func viewWillAppear (_ animated: Bool) {
        tableView.frame.origin = CGPoint(x: 0, y: 55.0)
        extendedLayoutIncludesOpaqueBars = true
    }
    
    func updateUiTableState() {
        tableView.frame.origin = CGPoint(x: 0, y: 55.0)
        self.tableView.reloadData()
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    
    @IBAction func editContact(_ sender: Any) {
        
        
        let updateViewController = AppStoryboard.Contacts.instance.instantiateViewController(withIdentifier: DeleteViewController.storyboardID) as? DeleteViewController
        
        self.present(DeleteViewController.newInstance(uiViewController: updateViewController!, parentViewController: self), animated: true, completion: {
            
        })
        
        
    }
    
    
    /*
     *
     * MARK: UITableView Delegate methods
     *
     */
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let vc =  self.tabBarController as! ContactTabBarViewController
         if vc.isFiltering() {
           return filteredContact.count
         }else {
           return contactList.count
         }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        let contact: Contact
        let vc =  self.tabBarController as! ContactTabBarViewController
        if vc.isFiltering() {
            cell = tableView.dequeueReusableCell(withIdentifier: "contacCell", for: indexPath)
            
            contact = filteredContact[indexPath.row]
            let name = cell.viewWithTag(1) as? UILabel
            name?.text =  contact.name
            let lastname = cell.viewWithTag(2) as? UILabel
            lastname?.text = contact.lastname
            let age = cell.viewWithTag(3) as? UILabel
            age?.text = contact.age
            let numberPhone = cell.viewWithTag(4) as? UILabel
            numberPhone?.text = contact.numberPhone
            
            self.tableView.reloadData()
            
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "contacCell", for: indexPath)
           
            contact = contactList[indexPath.row]
            let name = cell.viewWithTag(1) as? UILabel
            name?.text =  contact.name
            let lastname = cell.viewWithTag(2) as? UILabel
            lastname?.text = contact.lastname
            let age = cell.viewWithTag(3) as? UILabel
            age?.text = contact.age
            let numberPhone = cell.viewWithTag(4) as? UILabel
            numberPhone?.text = contact.numberPhone
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < contactList.count {
            delete = {
                self.contactList.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
        }
    }
    
    
    
}



