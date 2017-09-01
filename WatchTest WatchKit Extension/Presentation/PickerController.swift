//
//  PickerController.swift
//  WatchTest
//
//  Created by Yaroslav Bondar VironIT on 28.08.17.
//  Copyright © 2017 VironIT. All rights reserved.
//

import WatchKit

class PickerController: WKInterfaceController {
    
    @IBOutlet var picker: WKInterfacePicker!
    @IBOutlet var flagsPicker: WKInterfacePicker!
    
    let flags: [(name: String, abbr: String)] = [("Belgium", "be"),
                                                 ("USA", "us"),
                                                 ("UK", "gb"),
                                                 ("India", "in"),
                                                 ("China", "cn"),
                                                 ("Australia", "au")]
    
    var pickerItems: [WKPickerItem] = []
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setupPickers()
    }
    
    private func setupPickers() {
        pickerItems = flags.map {
            let pickerItem = WKPickerItem()
            pickerItem.title = $0.name
            pickerItem.caption = $0.abbr
            
            /// or 1
            let image = WKImage(imageName: $0.abbr) /// from watch bundle

            /// or 2
//            guard let uiImage = UIImage(named: $0.abbr) else { return pickerItem }
//            let image = WKImage(image: uiImage)
           
            pickerItem.contentImage = image /// not for list picker style. here example only
            pickerItem.accessoryImage = image
            return pickerItem
        }
        
        picker.setItems(pickerItems)
        flagsPicker.setItems(pickerItems)
    }
    
    @IBAction func actionPicker(_ value: Int) {
        print("List Picker: \(flags[value].name)")
    }
}
