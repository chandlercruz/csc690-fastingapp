//
//  FastingDataViewController.swift
//  FastingApp
//
//  Created by Chris Manaoat on 12/9/20.
//

import UIKit

class FastingDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var fastingTimerViewController: FastingTimerViewController?
    
    @IBOutlet weak var tableView: UITableView!
    
    var fastList: [Fast] {
        return fastingTimerViewController?.FastList ?? []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        for fast in fastList {
            print("fast starts at \(fast.startTime) and ends at \(fast.endTime) for a total of \(fast.timeFasted) hours")
        }
    }
    
    @IBOutlet weak var HeaderLabelCell: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
//        let row = indexPath.row
        
        
        return cell
    }
    
    
}
