//
//  LoginViewController.swift
//  GrainChain Test
//
//  Created by Tecnocen on 3/6/19.
//  Copyright © 2019 Ana. All rights reserved.
//
import Foundation
import AVKit
import AVFoundation
import MaterialComponents.MaterialTextFields

class LoginViewController: UITableViewController, UITextFieldDelegate {
    //MARK: IBOutlets
    
    @IBOutlet var emailTextField: MDCTextField!
    @IBOutlet var passwordTextField: MDCTextField!
    @IBOutlet var rememberUserSwitch: UISwitch!
    @IBOutlet var eyeButton: UIButton!
    
    //MARK: Injection
    let loginVM = TokenViewModel(dataService: RequestToken())
    let savedUserVM = SavedUserViewModel()
    //Controllers for Android Animation
    var emailInputController: MDCTextInputControllerUnderline!
    var passwordInputController: MDCTextInputControllerUnderline!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        //Asign material effect to MDCTextFields
        emailInputController = MDCTextInputControllerUnderline(textInput: emailTextField)
        passwordInputController = MDCTextInputControllerUnderline(textInput: passwordTextField)
        showPassword()
        emailTextField.clearButtonMode = .never
        passwordTextField.clearButtonMode = .never
        
    }
    func showPassword(){
        eyeButton.setImage(UIImage.init(named: "eye_close"), for: .normal)
        eyeButton.setImage(UIImage.init(named: "eye_open"), for: .selected)
    }
    
    func requestToken() {
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            self.emailTextField.becomeFirstResponder()
            self.showAlert(title: "", message: "Por favor ingresa tu usuario")
            return
        } else if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ==  "" {
            self.passwordTextField.becomeFirstResponder()
            self.showAlert(title: "", message: "Por favor ingresa tu contraseña")
            return
        }
        
        loginVM.requestToken(username: emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
                             password: passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        loginVM.didFinishFetch = {
            guard let user = self.loginVM.user  else {
                return
            }
            self.savedUserVM.saveNameUser(user: user )
            self.navigateContactViewController()
        }
        loginVM.unauthorized = {
            self.showAlert(title: "", message: "Cliente o contraseña incorrectos")
            self.loginVM.errorMessage = ""
        }
        loginVM.showAlertClosure = {
            if self.loginVM.errorMessage != nil && self.loginVM.errorMessage != "" {
                self.showAlert(title: "Ha ocurrido un error", message: self.loginVM.errorMessage!)
                self.loginVM.errorMessage = ""
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:
            NSLocalizedString("OK", comment: "Default action"),style: .default, handler: { _ in
                _ = self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func navigateContactViewController() {
        let storyboard = AppStoryboard.Contacts.instance
        
        let viewController: UIViewController = storyboard.instantiateViewController(withIdentifier: ContactTabBarViewController.storyboardID)
        let navigationController = UINavigationController(rootViewController: viewController)
        self.present(navigationController, animated: true) {
            if self.rememberUserSwitch.isOn {
                UserDefaults.standard.set(true, forKey: TokenViewModel.DEFAULTS_KEY_REMEMBER_EMAIL)
            } else {
                self.emailTextField.text = ""
                UserDefaults.standard.set(false, forKey: TokenViewModel.DEFAULTS_KEY_REMEMBER_EMAIL)
            }
            self.passwordTextField.text = ""
        }
    }
    //MARK: IBAction
    
    @IBAction func passwordButton(_ sender: Any) {
        if eyeButton.isSelected {
            eyeButton.isSelected = false
            passwordTextField.isSecureTextEntry = true
        } else {
            eyeButton.isSelected = true
            passwordTextField.isSecureTextEntry = false
        }
    }
    
    @IBAction func login(_ sender: Any) {
        requestToken()
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
     *
     * UITableViewController delegate methods
     *
     */
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0.0
        case 1:
            return 0.0
        default:
            break
        }
        return 21.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            break
        }
        return 1
    }
    
    
}
