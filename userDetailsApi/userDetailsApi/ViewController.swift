//
//  ViewController.swift
//  userDetailsApi
//
//  Created by Mac on 01/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    var userDetailArray : [UserDetails] = []

    @IBOutlet weak var userDetailTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        parseUserDetails()
    }
    
    func parseUserDetails(){
        let str = "https://jsonplaceholder.typicode.com/users"
        let url = URL(string: str)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error == nil {
                do {
                    self.userDetailArray =  try JSONDecoder().decode([UserDetails].self, from: data!)
                    DispatchQueue.main.async {
                        self.userDetailTable.reloadData()
                    }
                } catch {
                    print("Something went wrong!")
                }
            }
        }.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDetailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UserTableViewCell
        let user = userDetailArray[indexPath.row]
        cell.idLabel.text = "Id : \(user.id)"
        cell.nameLabel.text = "Name : \(user.name)"
        cell.usernameLabel.text = "Username : \(user.username)"
        cell.emailLabel.text = "Email : \(user.email)"
        cell.addressLabel.text = "Address : \(user.address.street), \(user.address.suite), \(user.address.city), \(user.address.zipcode), \(user.address.geo.lat), \(user.address.geo.lng)"
        cell.phoneLabel.text = "Phone : \(user.phone)"
        cell.websiteLabel.text = "Website : \(user.website)"
        cell.companyLabel.text = "Company : \(user.company.name), \(user.company.catchPhrase), \(user.company.bs)"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 536.0
    }
    
}

