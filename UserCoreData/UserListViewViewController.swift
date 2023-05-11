//
//  UserListViewViewController.swift
//  UserCoreData
//
//  Created by Sadia on 5/5/23.
//

import UIKit

class UserListViewViewController: UIViewController{
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var databaseManager = DatabaseManager()
    
    var users:[UserEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UserListViewViewController: UISearchBarDelegate {
    //MARK:- SEARCH BAR DELEGATE METHOD FUNCTION

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""

        users = databaseManager.fetchUser()

        searchBar.endEditing(true)
        tableView.reloadData()
    }



    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            users = databaseManager.fetchUser()
        }else{
            users = databaseManager.fetchUser(keyword: searchText)
        }
        
        tableView.reloadData()
    }
}

