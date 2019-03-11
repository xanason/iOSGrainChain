//
//  ContactTabBarViewController.swift
//  GrainChain Test
//
//  Created by Tecnocen on 3/6/19.
//  Copyright © 2019 Ana. All rights reserved.
//


import UIKit

var isCheckedGlobal = Bool()

class ContactTabBarViewController: UITabBarController, UISearchBarDelegate, UISearchResultsUpdating{
    //UISearchResultsUpdating
    //IBOutlets
    @IBOutlet var barLoans: UITabBar!
    var contactViewController : ContactListViewController?
    //MARK: Injection
    var contactList:[Contact] = Contact.generateModelArray()
    var filteredContact:[Contact] = Contact.generateModelArray()
    let loginVM = TokenViewModel(dataService: RequestToken())
    let savedUserVM = SavedUserViewModel()
    let searchBar = UISearchBar()
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        searchBar.delegate = self
        setupColors()
        barLoans.selectionIndicatorImage = UIImage().createSelectionIndicator(color: UIColor.white, size: CGSize(width: barLoans.frame.width/CGFloat(barLoans.items!.count), height: barLoans.frame.height + 5), lineHeight: 3.0)
        
        self.edgesForExtendedLayout = UIRectEdge.bottom
        self.extendedLayoutIncludesOpaqueBars = true;
        showUserName()
        configurarControladorDeBusca()
        
        
        
       filteredContact = contactList
    }
    func showUserName(){
        
        let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 150.0, height: 44.0))
        let button = UIButton.init(type: .custom)
        button.setBackgroundImage(UIImage(named: "back"), for: .normal)
        button.frame = CGRect(x: 0.0, y: 5.0, width: 30.0, height: 30.0)
        button.addTarget(self, action: #selector(backButton(button:)), for: .touchUpInside)
        customView.addSubview(button)
        let marginX = CGFloat(button.frame.origin.x + button.frame.size.width + 5)
        let label = UILabel(frame: CGRect(x: marginX, y: 0.0, width: 100.0, height: 44.0))
        self.savedUserVM.loadUser()
        label.text = self.savedUserVM.selectedUser?.name
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.right
        
        customView.addSubview(label)
        
        let leftButton = UIBarButtonItem(customView: customView)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
    func configurarControladorDeBusca() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self;
        searchController.loadViewIfNeeded()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Busca un nombre"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.barTintColor = navigationController?.navigationBar.barTintColor
        searchController.searchBar.tintColor = self.view.tintColor
        navigationItem.titleView = searchController.searchBar
    }
    
    override func viewDidLayoutSubviews() {
        self.tabBar.frame = CGRect(x: 0, y: 0, width:self.view.bounds.size.width, height: 55)
    }
    func setupColors(){
        let bar: UINavigationBar? = navigationController?.navigationBar
        bar?.barTintColor = CommonUtils.hexStringToUIColor(hex: "53AA2A" )
        
        barLoans.tintColor = UIColor.white
        if #available(iOS 10.0, *) {
            barLoans.unselectedItemTintColor = UIColor.white
        } else {
            // Fallback on earlier versions
            UITabBar.appearance().tintColor = UIColor.white
        }
    }
    
    @objc func backButton(button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    //SearchBar
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isCheckedGlobal = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isCheckedGlobal = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isCheckedGlobal = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isCheckedGlobal = false;
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text! == "" {
            filteredContact = contactList
        } else {
            filteredContact = contactList.filter {
               $0.name.lowercased().contains(searchController.searchBar.text!.lowercased()) }
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
}


