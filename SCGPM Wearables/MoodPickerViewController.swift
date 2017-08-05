//
//  MoodPickerViewController.swift
//  SCGPM Wearables
//
//  Created by Isaac Liao on 8/4/17.
//  Copyright © 2017 SCGPM. All rights reserved.
//

import UIKit

class MoodPickerViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    
    @IBOutlet weak var pickerView: UIPickerView!
    let pickerData = [["Stressed","Normal","Happy"]]
    var selectedMood:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(1, inComponent: 0, animated: false)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(_
        pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int
        ) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(_
        pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int
        ) -> String? {
        return pickerData[component][row]
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int)
    {
        self.selectedMood = pickerData[0][pickerView.selectedRow(inComponent: 0)]
    }
}
