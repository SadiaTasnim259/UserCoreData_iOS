//
//  UserListViewViewController.swift
//  UserCoreData
//
//  Created by Sadia on 5/5/23.
//

import UIKit

class UserListViewViewController: UIViewController{
   
    @IBOutlet weak var tableView: UITableView!
    
    var databaseManager = DatabaseManager()
    
    var users:[UserEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        users = databaseManager.fetchUser()
        
        tableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
                self.navigationController?.pushViewController(registerVC, animated: true)
    }
}

extension UserListViewViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserEntityTableCellTableViewCell", for: indexPath) as? UserEntityTableCellTableViewCell else{
            return UITableViewCell()
        }
        
        let user = users[indexPath.row]
        
        
        cell.userName.text = (user.firstName ?? "")+" "+(user.lastName ?? "")
        cell.userEmail.text = user.email
        
        let imageURL = URL.documentsDirectory.appending(components: user.imageName ?? "").appendingPathExtension("png")
        cell.userImageView.image = UIImage(contentsOfFile: imageURL.path)
        

        return cell
    }
}
