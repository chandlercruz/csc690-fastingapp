//
//  FastDatePickerViewController.swift
//  FastingApp
//
//  Created by Chandler Cruz
//

import UIKit

class FastTimePickerViewController: UIViewController {

    @IBOutlet weak var txtDate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtDate.delegate = self
    }
}

extension FastTimePickerViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.openDatePicker()
    }
}

extension FastTimePickerViewController {
    func openDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        datePicker.addTarget(self, action: #selector(self.datePickerHandler(datePicker:)), for: .valueChanged)
        txtDate.inputView = datePicker //keyboard
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y:0, width: self.view.frame.width, height: 60))
        
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelBtnClick))
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneBtnClick))
        let flexibleBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([cancelBtn, flexibleBtn, doneBtn], animated: false)
        txtDate.inputAccessoryView = toolbar
        
    }
    
    @objc
    func cancelBtnClick() {
        txtDate.resignFirstResponder()
    }
    
    @objc
    func doneBtnClick() {
        if let datePicker = txtDate.inputView as? UIDatePicker{
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .medium
            txtDate.text = dateFormatter.string(from: datePicker.date)
            print(datePicker.date)
        }
        
        txtDate.resignFirstResponder()
    }
    
    @objc func datePickerHandler(datePicker: UIDatePicker) {
        print(datePicker.date)
    }
}
