//
//  FastingDataViewController.swift
//  FastingApp
//
//  Created by Chris Manaoat on 12/9/20.
//

import UIKit

class FastingDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var fastingTimerViewController: FastingTimerViewController?
    
    let brain = FastListBrain()
    var FastList: [Fast] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    var totalFastAmount: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(getFastList), name: FastListBrain.getList, object: nil)
        brain.getFastList()
        calcTotalFast()
    }
    
    func calcTotalFast() {
        var currFastAmount: Double = 0
        for element in FastList{
            currFastAmount = element.timeFasted
            print(currFastAmount)
            totalFastAmount = totalFastAmount + currFastAmount
        }
    }
    
    @objc func getFastList() {
        FastList = FastListBrain.FastList
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBOutlet weak var HeaderLabelCell: UITableView!
    
    func calculateTotHourFast() -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let row = indexPath.row
        
        print(row)
        switch row{
        case 0:
            cell.textLabel?.text = "Total hours fasted \(totalFastAmount)"
        case 1:
            var averageFast = totalFastAmount / Double(FastList.count)
            cell.textLabel?.text = "Average fast length \(averageFast)"
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
