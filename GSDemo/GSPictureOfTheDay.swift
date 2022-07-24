//
//  GSPictureOfTheDay.swift
//  GSDemo
//
//  Created by Chandan Kumar on 24/07/22.
//

import Foundation
import UIKit

class GSPictureOfTheDay: UIViewController {
    
    @IBOutlet weak var selectDateTextfield: UITextField!
    @IBOutlet weak var pictureOfTheDayView: UIView!
    @IBOutlet weak var sellectPictureButton: UIButton!
    
    var pictureView: GSDisplayView?
    var pictureOfTheDay: PictureOfDate?
    
    var selectedDate = ""
    let selectDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPictureOfTheDay()
        showDatePicker()
        setPictureOfDate()
        setupUI()
    }
    
    func setupUI() {
        pictureView = .fromNib()
        pictureOfTheDayView.addSubview(pictureView!)
        
        pictureView?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pictureView!.topAnchor.constraint(equalTo: pictureOfTheDayView.topAnchor, constant: 0),
            pictureView!.bottomAnchor.constraint(equalTo: pictureOfTheDayView.bottomAnchor, constant: 0),
            pictureView!.leadingAnchor.constraint(equalTo: pictureOfTheDayView.leadingAnchor, constant: 0),
            pictureView!.trailingAnchor.constraint(equalTo: pictureOfTheDayView.trailingAnchor, constant: 0)
        ])
    }
    
    func setPictureOfDate() {
        if !(selectedDate.count > 0) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = k_DATE_FORMAT
            selectedDate = dateFormatter.string(from: Date())
        }
        selectDateTextfield.text = selectedDate
        getPictureOfTheDay()
    }
    
    func showDatePicker() {
        
        self.selectDateTextfield.datePicker(target: self,
                                            doneAction: #selector(dateSelected),
                                            cancelAction: #selector(cancelAction),
                                            datePickerMode: .date)
    }
    
    @objc func cancelAction() {
        self.selectDateTextfield.resignFirstResponder()
    }
    
    @objc func dateSelected() {
        if let datePickerView = self.selectDateTextfield.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = k_DATE_FORMAT
            selectedDate = dateFormatter.string(from: datePickerView.date)
            selectDateTextfield.text = selectedDate
            self.selectDateTextfield.resignFirstResponder()
            getPictureOfTheDay()
        }
        
    }
    
    func getPictureOfTheDay(){
        if !(selectedDate.count > 0) {
            return
        }
        
        ReachabilityManager.shared.isReachable {
            GSNetworkService().getPictireOfDate(date: self.selectedDate) { response in
                DispatchQueue.main.async {
                    self.pictureOfTheDay = response
                    self.pictureView?.pictureOfTheDay = response
                }
            } onFailure: { error in
                DispatchQueue.main.async {
                    self.showAlert(text: "Some thing went wrong, please try again.")
                }
            }
            
        } failure: {
            GSNetworkService().showNetworkAlert()
        }
    }
    
    @IBAction func savePictureOfTheDay(_ sender: Any) {
        sellectAnimation ()
        let pictureExists = GSStorageService.shareInstance.checkPictureExistsExists(date: selectedDate)
        if !pictureExists {
            guard let favouritePicture = self.pictureOfTheDay else { return }
            if let title = favouritePicture.title, let date = favouritePicture.date, let details = favouritePicture.details, let imageUrl = favouritePicture.imageUrl {
                GSStorageService.shareInstance.saveFavouritePicture(title: title, date: date, details: details, imageUrl: imageUrl)
                self.showAlert(title: "Success", message: "Your favourite picture has been stored successfully!")
            }
        } else {
            self.showAlert(title: "Alert!", message: "The sellected picture already exists!")
        }
    }
    
    func sellectAnimation () {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.sellectPictureButton.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
        }) { (finished) in
            UIView.animate(withDuration: 1, animations: {
                self.sellectPictureButton.transform = CGAffineTransform.identity
            })
        }
    }
    
}
