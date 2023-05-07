//
//  ViewController.swift
//  UserCoreData
//
//  Created by Sadia on 30/4/23.
//

import UIKit
import CoreData

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let databaseManager = DatabaseManager()
    var imageSelectedByUser: Bool = false
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fisrtName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add User"
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        guard let firstName = fisrtName.text, !firstName.trimmingCharacters(in: .whitespaces).isEmpty else{
            showAlert(message: "Please enter your first name")
            return
        }
        
        guard let lastName = lastName.text, !lastName.trimmingCharacters(in: .whitespaces).isEmpty else{
            showAlert(message: "Please enter your last name")
            return
        }
        
        guard let email = emailAddress.text, !email.trimmingCharacters(in: .whitespaces).isEmpty else{
            showAlert(message: "Please enter your email")
            return
        }
        
        guard let password = passwordField.text, !password.isEmpty else{
            showAlert(message: "Please enter your password")
            return
        }
        //Both true tokhon else e dhukbe na
        
        if !imageSelectedByUser{
            showAlert(message: "Plese select your Picture")
            return
        }
        
        let imageName = UUID().uuidString
        
        
        let user = UserModel(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            imageName: imageName)
        
        
        saveImageToDocumentDirectory(imageName: imageName)
        
        databaseManager.addUser(user)
        navigationController?.popViewController(animated: true)
    }
    
    //Saving the image in document directory.
    func saveImageToDocumentDirectory(imageName: String){
        let fileURL = URL.documentsDirectory.appending(components: imageName).appendingPathExtension("png")
        
        if let data = imageView.image?.pngData(){
            do{
                try data.write(to: fileURL)
            }catch{
                print("Saving image to Document Directory error:",error)
            }
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
    }
    
    func showAlert(message: String) -> Void {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true)
    }
    
    
    @IBAction func tappedImage(_ sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true)
        self.imageSelectedByUser = true
    }
    
    
}

