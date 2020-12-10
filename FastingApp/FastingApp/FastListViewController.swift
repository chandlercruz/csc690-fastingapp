//
//  FastListViewController.swift
//  FastingApp
//
//  Created by student on 12/10/20.
//

import UIKit

class FastListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var fastList: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.delegate = self
//        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fastList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
}
