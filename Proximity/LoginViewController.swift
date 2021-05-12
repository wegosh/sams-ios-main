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
    
    let api_url =  "http://192.168.1.13:8000/api/auth/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token: String? = KeychainWrapper.standard.string(forKey: "auth_token")
        
        
        self.textFieldUsername.delegate = self
        self.textFieldPassword.delegate = self
        // Do any additional setup after loading the view.
        
        if token != nil{
            print("token: \(token!)")
            self.performSegue(withIdentifier: "performLoginSegue", sender: self)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func retreiveUserDataFromApi(user: User){
        var userInstance = User(uID: nil, username: user.username, token: user.token, isLogin: false)
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
                    
                    let saveAccessToken: Bool = KeychainWrapper.standard.set(userInstance.token!, forKey: "auth_token")
                    let saveUserID: Bool = KeychainWrapper.standard.set(userID, forKey: "id")
                    print("ID OK")
                }
            case .failure(let tokenFailure):
                print("Token failure")
            }
        }
    }
    
    func userLoginToGetToken(user: User, password: String){
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
                        self.retreiveUserDataFromApi(user: userInstance)
                    }
                    
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        var user = User(uID: nil, username: textFieldUsername.text ?? "", token: nil, isLogin: false)
        userLoginToGetToken(user: user, password: textFieldPassword.text ?? "")
        self.performSegue(withIdentifier: "performLoginSegue", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "performLoginSegue"{

                let destView = segue.destination as! MainViewController
                
        }
    }

}

