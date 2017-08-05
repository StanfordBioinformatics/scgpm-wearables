//
//  FirstViewController.swift
//  SCGPM Wearables
//
//  Created by Isaac Liao on 7/31/17.
//  Copyright © 2017 SCGPM. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var moodButton: UIButton!
    @IBOutlet weak var statusText: UITextView!
    @IBOutlet weak var sickSwitch: UISwitch!
    @IBOutlet weak var sickNotes: UITextField!
    @IBOutlet weak var travelSwitch: UISwitch!
    @IBOutlet weak var travelNotes: UITextField!
    var selectedDate: Date!
    var selectedMood: String!
    var dateFormatter: DateFormatter!
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        if unwindSegue.source is DatePickerViewController {
            let dpvc:DatePickerViewController = unwindSegue.source as! DatePickerViewController
            self.selectedDate = dpvc.datePicker.date
            dateButton.setTitle(dateFormatter.string(from: selectedDate), for: UIControlState.normal)
        } else if unwindSegue.source is MoodPickerViewController {
            let mpvc:MoodPickerViewController = unwindSegue.source as! MoodPickerViewController
            self.selectedMood = mpvc.selectedMood
            moodButton.setTitle(self.selectedMood, for: UIControlState.normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        selectedDate = Date()
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateButton.setTitle(dateFormatter.string(from: selectedDate), for: UIControlState.normal)
        selectedMood = "Normal"
        moodButton.setTitle(self.selectedMood, for: UIControlState.normal)
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        do {
            let documentsDir = try FileManager.default.url(for: .documentDirectory, in:.userDomainMask, appropriateFor:nil, create:true)
            let filename = "notes.tsv"
            let path = documentsDir.appendingPathComponent(filename)
            
            if (!FileManager.default.fileExists(atPath: path.path)) {
                DispatchQueue.main.async {
                    self.statusText.text = self.statusText.text + "No file found, creating \(filename)...\n"
                    print("No file found, creating \(filename)...")
                }
                try "Date\tSick?\tSickness notes\tTravel?\tTravel notes\tMood\n".write(to:path, atomically:true, encoding:String.Encoding.unicode)
            }

            var row = self.dateFormatter.string(from: self.selectedDate) + "\t"
            
            if self.sickSwitch.isOn {
                row += "yes\t"
            } else {
                row += "no\t"
            }
            row += (self.sickNotes.text! + "\t")
            
            if self.travelSwitch.isOn {
                row += "yes\t"
            } else {
                row += "no\t"
            }
            row += (self.travelNotes.text! + "\t")
            
            row += (self.selectedMood + "\n")
            
            DispatchQueue.main.async {
                self.statusText.text = self.statusText.text + "Writing row:\n\(row)"
                print("Writing row:\n\(row)")
            }
            
            let file:FileHandle? = FileHandle(forUpdatingAtPath: path.path)
            file?.seekToEndOfFile()
            file?.write(row.data(using: String.Encoding.unicode)!)
            file?.closeFile()

            DispatchQueue.main.async {
                self.statusText.text = self.statusText.text + "Done writing!\n"
                print("Done writing!")
            }
        }
        catch {
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

