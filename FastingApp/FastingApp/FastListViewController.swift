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
        
        self.title = "List of Fasts"
        NotificationCenter.default.addObserver(self, selector: #selector(getFastList), name: FastListBrain.getList, object: nil)
        brain.getFastList()
        fastList.sort { (lhs: Fast, rhs: Fast) -> Bool in
            return lhs.endTime > rhs.endTime
        }
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
        let startDate = fastList[row].startTime
        let endDate = fastList[row].endTime
        
        let dateFormatterIn = DateFormatter()
        dateFormatterIn.dateFormat = "yyyy-MM-dd HH:mm:ss zzzz"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterPrint.dateFormat = "MMM dd, yyyy h:MM a"
        let fastLength = fastList[row].timeFasted
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "Start: " + dateFormatterPrint.string(from: startDate) +
            "\nEnd: " + dateFormatterPrint.string(from: endDate) +
            "\nDuration of fast: " + String(format: "%.2f", fastLength) + " hours"
        return cell
    }
}
