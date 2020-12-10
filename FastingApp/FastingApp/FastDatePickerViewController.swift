//
//  FastDatePickerViewController.swift
//  FastingApp
//
//  Created by Chandler Cruz
//

import UIKit

struct Fast {
    var startTime: Date
    var endTime: Date
}

class FastTimePickerViewController: UIViewController {

    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var submitFast: UIButton!
    
    var userStartTime: Date? = nil
    var userEndTime: Date? = nil
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        if userStartTime != nil && userEndTime != nil {
            let newFast = Fast(startTime: userStartTime!, endTime: userEndTime!)
            
            print("New Fast started at \(String(describing: newFast.startTime )) and ended at \(String(describing: newFast.endTime))")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startDate.delegate = self
        endDate.delegate = self
    }
}

extension FastTimePickerViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.startDatePicker()
        self.endDatePicker()
    }
    
    
}

extension FastTimePickerViewController {
    func startDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        datePicker.addTarget(self, action: #selector(self.datePickerHandler(datePicker:)), for: .valueChanged)
        startDate.inputView = datePicker //keyboard
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y:0, width: self.view.frame.width, height: 60))
        
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelBtnClickStart))
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneBtnClickStart))
        let flexibleBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([cancelBtn, flexibleBtn, doneBtn], animated: false)
        startDate.inputAccessoryView = toolbar
        
    }
    
    func endDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        datePicker.addTarget(self, action: #selector(self.datePickerHandler(datePicker:)), for: .valueChanged)
        endDate.inputView = datePicker //keyboard
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y:0, width: self.view.frame.width, height: 60))
        
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelBtnClickEnd))
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneBtnClickEnd))
        let flexibleBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([cancelBtn, flexibleBtn, doneBtn], animated: false)
        endDate.inputAccessoryView = toolbar
        
    }
    
    @objc
    func cancelBtnClickStart() {
        startDate.resignFirstResponder()
    }
    
    @objc
    func doneBtnClickStart() {
        if let datePicker = startDate.inputView as? UIDatePicker{
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .medium
            startDate.text = dateFormatter.string(from: datePicker.date)
            userStartTime = datePicker.date
            print(datePicker.date)
        }
        
        startDate.resignFirstResponder()
    }
    
    @objc
    func cancelBtnClickEnd() {
        endDate.resignFirstResponder()
    }
    
    @objc
    func doneBtnClickEnd() {
        if let datePicker = endDate.inputView as? UIDatePicker{
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .medium
            endDate.text = dateFormatter.string(from: datePicker.date)
            userEndTime = datePicker.date
            print(datePicker.date)
        }
        
        endDate.resignFirstResponder()
    }
    
    @objc func datePickerHandler(datePicker: UIDatePicker) {
        print(datePicker.date)
    }
}