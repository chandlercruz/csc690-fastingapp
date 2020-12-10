//
//  ViewController.swift
//  FastingApp
//
//  Created by Chandler Cruz
//

import UIKit

class FastingTimerViewController: UIViewController, FastTimePickerDelegate {
    
    
    @IBOutlet weak var startTimeField: UITextField!
    @IBOutlet weak var startEndButton: UIButton!
    
    var userHomeStartTime: Date? = nil
    
    var FastList: [Fast] = []
    
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
        FastList.append(newFast)
        print("Current Fasts:")
//        for fast in FastList {
//            print("fast starts at \(fast.startTime) and ends at \(fast.endTime) for a total of \(fast.timeFasted) hours")
//        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimeField.delegate = self
        
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
        }
        startTimeField.resignFirstResponder()
    }
    
    @objc func datePickerHandler(datePicker: UIDatePicker) {
        print(datePicker.date)
    }
}


