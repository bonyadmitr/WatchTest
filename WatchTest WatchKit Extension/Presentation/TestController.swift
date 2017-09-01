//
//  TestController.swift
//  WatchTest
//
//  Created by Yaroslav Bondar VironIT on 28.08.17.
//  Copyright © 2017 VironIT. All rights reserved.
//

import WatchKit

class TestController: WKInterfaceController {
    
    @IBOutlet var button: WKInterfaceButton!
    
    var buttonPressTimes = 0
    @IBAction func actionButton() {
        buttonPressTimes += 1
        button.setTitle("\(buttonPressTimes)")
    }
    
    @IBOutlet var image: WKInterfaceImage!
    @IBOutlet var separator: WKInterfaceSeparator!
    @IBAction func actionPaymentButton() {
        print("actionPaymentButton")
    }
    @IBOutlet var someSwitch: WKInterfaceSwitch!
    @IBAction func actionSomeSwitch(_ value: Bool) {
        button.setEnabled(value)
        print("actionSomeSwitch")
    }
    @IBOutlet var slider: WKInterfaceSlider!
    @IBAction func actionSlider(_ value: Float) {
        print("Slider", value)
    }
    @IBOutlet var picker: WKInterfacePicker!
    @IBAction func actionPicker(_ value: Int) {
        print("Picker", value)
    }
    @IBOutlet var group: WKInterfaceGroup!
    @IBOutlet var label: WKInterfaceLabel!
    @IBOutlet var date: WKInterfaceDate!
    @IBOutlet var timer: WKInterfaceTimer!
    @IBOutlet var map: WKInterfaceMap!
    @IBOutlet var movie: WKInterfaceMovie!
    
     // MARK: - @available(watchOS 3.0, *)
    
    @IBOutlet var paymentButton: WKInterfacePaymentButton!
    @IBOutlet var inlineMovie: WKInterfaceInlineMovie!
    
    @IBOutlet var tapGesture: WKTapGestureRecognizer!
    @IBAction func actionTapGesture(_ sender: Any) {
        print("actionTapGesture")
    }
    @IBOutlet var longPressGesture: WKLongPressGestureRecognizer!
    @IBAction func actionLongPressGesture(_ sender: Any) {
        print("actionLongPressGesture")
    }
    
    @IBOutlet var panGesture: WKPanGestureRecognizer!
    @IBAction func actionPanGesture(_ sender: Any) {
        print("actionPanGesture")
    }

    @IBOutlet var swiperGesture: WKSwipeGestureRecognizer!
    @IBAction func actionSwiperGesture(_ sender: Any) {
        print("actionSwiperGesture")
    }
    
    override init() {
        /// Initialize properties here.
        super.init()
        /// It is now safe to access interface objects.
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        image.setImage(#imageLiteral(resourceName: "us"))
        separator.setColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
        
        group.setBackgroundColor(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))
        group.setCornerRadius(10)
        
        pickerSetup()
        setupMovies()
    }
    
    private func pickerSetup() {
        let item1 = WKPickerItem()
        item1.title = "Title 1"
        item1.caption = "Caption 1"
        
        let item2 = WKPickerItem()
        item2.title = "Title 2"
        
        let items = [item1, item2]
        picker.setItems(items)
        picker.setSelectedItemIndex(1)
    }
    
    private func setupMovies() {
        guard let url = URL(string: "http://clips.vorwaerts-gmbh.de/VfE_html5.mp4") else { return }
        movie.setMovieURL(url)
//        inlineMovie.setMovieURL(url)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func pickerDidFocus(_ picker: WKInterfacePicker) {
        print("- pickerDidFocus")
    }
    
    override func pickerDidSettle(_ picker: WKInterfacePicker) {
        print("- pickerDidSettle")
    }
    
    override func pickerDidResignFocus(_ picker: WKInterfacePicker) {
        print("- pickerDidResignFocus")
    }
}
