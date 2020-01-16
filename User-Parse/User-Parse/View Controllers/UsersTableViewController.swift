//
//  UsersTableViewController.swift
//  User-Parse
//
//  Created by Austin Potts on 1/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
    var apiController = APIController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiController.getUsers { (error) in
            if let error = error {
                NSLog("Error getting users for tableview: \(error)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiController.user.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let user = apiController.user[indexPath.row]
        cell.textLabel?.text = user.name.first.capitalized + " " + user.name.last.capitalized
        
        guard let imageData = try? Data(contentsOf: user.picture.thumbnail) else {fatalError()}
        cell.imageView?.image = UIImage(data: imageData)
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowUserSegue" {
            guard let userDetailVC = segue.destination as? UserDetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let user = apiController.user[indexPath.row]
            userDetailVC.user = user
            
        }
    }


}
