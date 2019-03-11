//
//  AddContactViewController.swift
//  GrainChain Test
//
//  Created by Tecnocen on 3/6/19.
//  Copyright © 2019 Ana. All rights reserved.
//



import UIKit
import MaterialComponents.MaterialTextFields



class AddContactViewController: UITableViewController{
    
    
    //MARK: - IBOutlets
    var firstupdateContactList = [Contact]()
    @IBOutlet var nameTextField: MDCTextField!
    @IBOutlet var lastnameTextField: MDCTextField!
    @IBOutlet var ageTextField: MDCTextField!
    @IBOutlet var phoneNumberTextField: MDCTextField!
    
    //MARK: Variables
    var nameInputController: MDCTextInputControllerUnderline!
    var lastnameInputController: MDCTextInputControllerUnderline!
    var ageInputController: MDCTextInputControllerUnderline!
    var phoneNumberInputController: MDCTextInputControllerUnderline!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // configure the bar
        
        //Asign material effect to MDCTextFields
        nameInputController = MDCTextInputControllerUnderline(textInput: nameTextField)
        lastnameInputController = MDCTextInputControllerUnderline(textInput: lastnameTextField)
        ageInputController = MDCTextInputControllerUnderline(textInput: ageTextField)
        phoneNumberInputController = MDCTextInputControllerUnderline(textInput: phoneNumberTextField)
        
        tableView.frame.origin = CGPoint(x: 0, y: 55.0)
        extendedLayoutIncludesOpaqueBars = true
        
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
    
    
    func isFormDataValid() -> Bool {
        var errorMessage: String? = nil
        var errorField: UITextField?

        if (nameTextField.text == "") {
            errorMessage = "Por favor ingresa tu nombre"
            errorField = nameTextField
        } else if nameTextField.text!.count < 3 {
            errorMessage = "El nombre que ingresaste no es válido"
            errorField = nameTextField
        } else if (lastnameTextField.text == "") {
            errorMessage = "Por favor ingresa tu apellido paterno"
            errorField = lastnameTextField
        } else if lastnameTextField.text!.count < 3 {
            errorMessage = "Apellido  inválido"
            errorField = lastnameTextField
        }  else if (ageTextField.text == "") {
            errorMessage = "Por favor ingresa tu edad"
            errorField = ageTextField
        } else if (phoneNumberTextField.text == "") {
            errorMessage = "Por favor ingresa tu télefono"
            errorField = phoneNumberTextField
        } else if phoneNumberTextField.text!.count < 10  {
            errorMessage = "El teléfono que ingresaste no es válido"
            errorField = phoneNumberTextField
        }
        
        //Error message
        if (errorMessage != nil) {
            let alertController = UIAlertController(title: errorMessage, message: "", preferredStyle: .alert)
            let doneAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alertController.addAction(doneAction)
            present(alertController, animated: true) {
                if let error = errorField {
                    error.becomeFirstResponder()
                }
            }
            return false
        } else {
            return true
        }
        
    }
    //MARK: IBActions
    
    @IBAction func addContact(_ sender: Any) {
        if (self.isFormDataValid()) {
            firstupdateContactList = [
                Contact(name: nameTextField.text ?? "", lastname: lastnameTextField.text ?? "",age: ageTextField.text ?? "",numberPhone: phoneNumberTextField.text ?? "")]
            
            let vc = self.tabBarController?.viewControllers?.first as! ContactListViewController
            vc.updateContactList =  firstupdateContactList
            NotificationCenter.default.post(name: Notification.Name.addContactUpdate, object: firstupdateContactList)
            nameTextField.text = ""
            lastnameTextField.text = ""
            ageTextField.text = ""
            phoneNumberTextField.text = ""
        }
    }
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    
}

extension Notification.Name {
    static let addContactUpdate = Notification.Name(
        rawValue: "addContactUpdate")
}
