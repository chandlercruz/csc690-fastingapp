//
//  FastListViewController.swift
//  FastingApp
//
//  Created by student on 12/10/20.
//

import UIKit

class FastListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var fastList: [Fast] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    var brain = FastListBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(getFastList), name: FastListBrain.getList, object: nil)
        brain.getFastList()
//        print(fastList)
    }
    
    @objc func getFastList() {
        fastList = FastListBrain.FastList
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(fastList.count)
        return fastList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let row = indexPath.row
        var startDate = fastList[row].startTime
        var endDate = fastList[row].endTime
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(startDate)\n\(endDate)"
        return cell
    }
}
