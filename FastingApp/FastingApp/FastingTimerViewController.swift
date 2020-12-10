//
//  ViewController.swift
//  FastingApp
//
//  Created by Chandler Cruz
//

import UIKit
import CoreData
import MBCircularProgressBar

class FastingTimerViewController: UIViewController, FastTimePickerDelegate {
    
    
    @IBOutlet weak var startTimeField: UITextField!
    @IBOutlet weak var startEndButton: UIButton!
    @IBOutlet weak var progressBar: MBCircularProgressBarView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var userHomeStartTime: Date? = nil
    let brain = FastListBrain()

    var FastList2: [FastEntity] = []
    var FastList: [Fast] = []
    var fastAmount = 16.0
    
    @IBAction func startEndButtonPressed(_ sender: UIButton) {
        print("start end button pressed!")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let fastTimePickerViewController = segue.destination as? FastTimePickerViewController else {
            return
        }
        fastTimePickerViewController.userStartTime = userHomeStartTime
        fastTimePickerViewController.delegate = self
    }
    
    
    func addFast(newFast: Fast) {
        print("newfast \(newFast)")
//        FastList.append(newFast)
        print("Current Fasts:")
        NotificationCenter.default.addObserver(self, selector: #selector(addNewFast), name: FastListBrain.listHasUpdated, object: nil)
        brain.addFastToList(newFastItem: newFast)
        
        let newFastEntity = FastEntity(context: self.context)
        newFastEntity.startTime = newFast.startTime
        newFastEntity.endTime = newFast.endTime
        newFastEntity.timeFasted = newFast.timeFasted
        
        //let fastEntityToRemove =
        
        do {
            try self.context.save()
            print("saving an item")
        } catch {
            
        }
        
        print("after fast \(FastList)")
//        for fast in FastList {
//            print("fast starts at \(fast.startTime) and ends at \(fast.endTime) for a total of \(fast.timeFasted) hours")
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimeField.delegate = self
        
        fetchData()
    }
    
    func fetchData() {
        do {
            self.FastList2 = try context.fetch(FastEntity.fetchRequest())
                for fast in FastList2 {
                    let tempFastEntity = fast
                    let tempFast = Fast(startTime: tempFastEntity.startTime!, endTime: tempFastEntity.endTime!, timeFasted: tempFastEntity.timeFasted)
                    NotificationCenter.default.addObserver(self, selector: #selector(addNewFast), name: FastListBrain.listHasUpdated, object: nil)
                    brain.addFastToList(newFastItem: tempFast)
                    
                    print("pulling from core data")
                }
        } catch {
            
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func addNewFast () {
        FastList = FastListBrain.FastList
    }
}

extension FastingTimerViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.startDatePicker()
    }
}

extension FastingTimerViewController {
    func startDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(self.datePickerHandler(datePicker:)), for: .valueChanged)
        startTimeField.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelBtnClick))
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneBtnClick))
        let flexibleBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([cancelBtn, flexibleBtn, doneBtn], animated: false)
        startTimeField.inputAccessoryView = toolbar
    }
    
    @objc
    func cancelBtnClick() {
        startTimeField.resignFirstResponder()
    }
    
    @objc
    func doneBtnClick() {
        if let datePicker = startTimeField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .medium
            startTimeField.text = dateFormatter.string(from: datePicker.date)
            userHomeStartTime = datePicker.date
            print(datePicker.date)
            if userHomeStartTime != nil {
                UIView.animate(withDuration: 1.0) {
                    let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: self.userHomeStartTime!, to: Date())
                    let hoursDiff = Double(dateComponents.hour!)
                    let minutesDiff = Double(dateComponents.minute!)
                    let totalDiff: Double = hoursDiff + (minutesDiff/60.0)
                    let progressAmount = CGFloat(totalDiff/self.fastAmount * 100.0)
                    if progressAmount < 100.0 {
                        self.progressBar.value = progressAmount
                    } else {
                        self.progressBar.value = 100.0
                    }
                }
            }
        }
        startTimeField.resignFirstResponder()
    }
    
    @objc func datePickerHandler(datePicker: UIDatePicker) {
        print(datePicker.date)
    }
}


