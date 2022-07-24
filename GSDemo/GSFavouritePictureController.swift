//
//  GSFavouritePictureController.swift
//  GSDemo
//
//  Created by Chandan Kumar on 24/07/22.
//

import Foundation
import UIKit

class GSFavouritePictureController: UIViewController {
    
    @IBOutlet weak var pictureOfTheDayView: UIView!
    
    var pictureView: GSDisplayView?
    
    var pictureOfTheDay: PictureOfDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        pictureView = .fromNib()
        pictureView?.pictureOfTheDay = pictureOfTheDay
        pictureOfTheDayView.addSubview(pictureView!)
        
        pictureView?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pictureView!.topAnchor.constraint(equalTo: pictureOfTheDayView.topAnchor, constant: 0),
            pictureView!.bottomAnchor.constraint(equalTo: pictureOfTheDayView.bottomAnchor, constant: 0),
            pictureView!.leadingAnchor.constraint(equalTo: pictureOfTheDayView.leadingAnchor, constant: 0),
            pictureView!.trailingAnchor.constraint(equalTo: pictureOfTheDayView.trailingAnchor, constant: 0)
        ])
    }
    
    
    
    
}
