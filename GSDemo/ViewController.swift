//
//  ViewController.swift
//  GSDemo
//
//  Created by Chandan Kumar on 24/07/22.
//

import UIKit

let k_DATE_FORMAT = "yyyy-MM-dd"

class ViewController: UITabBarController, UITabBarControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewControllers = getTabBarControllers()
    }
    
    func getTabBarControllers() -> Array<UIViewController> {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pictureOfTheDayVC = storyboard.instantiateViewController(withIdentifier: "GSPictureOfTheDay") as! GSPictureOfTheDay
        let pictureOfTheDayTabItem = UITabBarItem(title: "", image: UIImage.init(named: "PictureOfDay"), selectedImage: UIImage.init(named: "PictureOfDay"))

        pictureOfTheDayVC.tabBarItem = pictureOfTheDayTabItem
        
        let favouritePicturesVC = storyboard.instantiateViewController(withIdentifier: "GSFavouritePictures") as! GSFavouritePictures
        let favouritePicturesTabItem = UITabBarItem(title: "", image: UIImage.init(named: "Favourite"), selectedImage: UIImage.init(named: "Favourite"))

        favouritePicturesVC.tabBarItem = favouritePicturesTabItem
        
        return [pictureOfTheDayVC, favouritePicturesVC]
    }
}

extension UIViewController {
    
    func showAlert(text : String){
        
        let alert = UIAlertController(title: "Alert!", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

extension UITextField {
    
    func datePicker<T>(target: T,
                       doneAction: Selector,
                       cancelAction: Selector,
                       datePickerMode: UIDatePicker.Mode = .date) {
        let screenWidth = UIScreen.main.bounds.width
        
        func buttonItem(withSystemItemStyle style: UIBarButtonItem.SystemItem) -> UIBarButtonItem {
            let buttonTarget = style == .flexibleSpace ? nil : target
            let action: Selector? = {
                switch style {
                case .cancel:
                    return cancelAction
                case .done:
                    return doneAction
                default:
                    return nil
                }
            }()
            
            let barButtonItem = UIBarButtonItem(barButtonSystemItem: style,
                                                target: buttonTarget,
                                                action: action)
            
            return barButtonItem
        }
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: screenWidth,
                                                    height: 216))
        datePicker.locale = .current
        datePicker.datePickerMode = datePickerMode
        datePicker.preferredDatePickerStyle = .inline
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: screenWidth,
                                              height: 44))
        toolBar.setItems([buttonItem(withSystemItemStyle: .cancel),
                          buttonItem(withSystemItemStyle: .flexibleSpace),
                          buttonItem(withSystemItemStyle: .done)],
                         animated: true)
        self.inputAccessoryView = toolBar
    }
}

extension UIViewController {
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}

