//
//  LoginViewController.swift
//  Proximity
//
//  Created by Patryk Węgrzyński on 12/05/2021.
//  Copyright © 2021 Estimote, Inc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper

struct User{
    var uID: Int?
    var username: String
    var token: String?
    var isLogin: Bool
}

class LoginViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    
    let api_url =  "https://wegorz.uk/api/auth/"
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token: String? = KeychainWrapper.standard.string(forKey: "auth_token")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        
        self.textFieldUsername.delegate = self
        self.textFieldPassword.delegate = self
        // Do any additional setup after loading the view.
        
        if token != nil{
            print("token: \(token!)")
            let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController")
            DispatchQueue.main.async {
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func retreiveUserDataFromApi(user: User) -> Bool{
        var userInstance = User(uID: nil, username: user.username, token: user.token, isLogin: false)
        var isUser: Bool = false
        print(user.token!)
        let header: HTTPHeaders = [
            "Authorization": "Token \(String(describing: user.token!))"
        ]
        AF.request("\(api_url)users/me/", headers: header).responseJSON{ response in
            switch response.result{
            case .success(let TOKEN_JSON):
                print("Token sucess")
                let userResponse = TOKEN_JSON as! NSDictionary
                if let userID = userResponse.object(forKey: "id") as? NSNumber{
                    userInstance.uID = Int(truncating: userID)
                        let saveAccessToken: Bool = KeychainWrapper.standard.set(userInstance.token!, forKey: "auth_token", withAccessibility: .afterFirstUnlock)
                        let saveUserID: Bool = KeychainWrapper.standard.set(userID, forKey: "id", withAccessibility: .afterFirstUnlock)
                        self.user?.uID = Int(truncating: userID)
                        self.user?.token = user.token
                        
                        var message = ""
                        
                        if (saveAccessToken && saveUserID){
                            message = "User has been logged in"
                            isUser = true
                        }else{
                            message = "User could not be logged in"
                        }
                        
                        print(message)
                    
                    
                    
                    
                }
            case .failure(_):
                print("Token failure")
            }
        }
        return isUser
    }
     
    
    func userLoginToGetToken(user: User, password: String) -> Bool{
        var isToken: Bool = false
        let param: [String: Any] = [
            "username": user.username,
            "password": password
        ]
        
        var userInstance = User(uID: nil, username: user.username, token: nil, isLogin: false)
        
        AF.request("\(api_url)token/login/", method: .post, parameters: param).responseJSON{ response in
            switch response.result{
                case .success(let JSON):
                    print("Success")
                    let response = JSON as! NSDictionary
                    if let token = response.object(forKey: "auth_token") as? NSString{
                        let tokenString = "\(token)"
                        userInstance.token = tokenString
                        let isUser = self.retreiveUserDataFromApi(user: userInstance)
                        isToken = true
                        if (isToken && isUser){
                            isToken = true
                        }
                    }
                    
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        return isToken
    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        let user = User(uID: nil, username: textFieldUsername.text ?? "", token: nil, isLogin: false)
        _ = userLoginToGetToken(user: user, password: textFieldPassword.text ?? "")
        let retreivedUserId: Int? = KeychainWrapper.standard.integer(forKey: "id")
        
        
        let retreivedAuthToken: String? = KeychainWrapper.standard.string(forKey: "auth_token")
        
            self.performSegue(withIdentifier: "performLoginSegue", sender: self)
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "performLoginSegue"{
            let retreivedAuthToken: String? = KeychainWrapper.standard.string(forKey: "auth_token")
                if retreivedAuthToken != nil{
                    _ = segue.destination as! MainViewController
                }else{
                    let alert = UIAlertController(title: "Login", message: "User could not be verified. Make sure that your password is correct.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
        }
    }

}

