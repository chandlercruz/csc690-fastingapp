//
//  FastingDataViewController.swift
//  FastingApp
//
//  Created by Chris Manaoat on 12/9/20.
//

import UIKit

class FastingDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBOutlet weak var HeaderLabelCell: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let row = indexPath.row
        
        print(row)
        switch row{
        case 0:
            cell.textLabel?.text = "Total hours fasted"
        case 1:
            cell.textLabel?.text = "Average fast length"
        case 2:
            cell.textLabel?.text = "List of fasts"
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        print(row)
        
        if row == 2{
            print("switching nav controller")
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "FastListViewController") as! FastListViewController
            navigationController?.pushViewController(destination, animated: true)
        }
    }
}
