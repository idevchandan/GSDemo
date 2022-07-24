//
//  GSDisplayView.swift
//  GSDemo
//
//  Created by Chandan Kumar on 24/07/22.
//

import UIKit
import AlamofireImage

class GSDisplayView: UIView {
    
    @IBOutlet weak var pictureOfTheDayImageView: UIImageView!
    @IBOutlet weak var pictureOfTheDayTitle: UILabel!
    @IBOutlet weak var pictureOfTheDayDate: UILabel!
    @IBOutlet weak var pictureOfTheDayTextView: UITextView!
    
    var pictureOfTheDay: PictureOfDate? {
        didSet {
            if let imageURL = pictureOfTheDay?.imageUrl, let title = pictureOfTheDay?.title, let date = pictureOfTheDay?.date, let details = pictureOfTheDay?.details {
                pictureOfTheDayImageView.af.setImage(withURL: URL(string: imageURL)!)
                pictureOfTheDayTitle.text = title
                pictureOfTheDayDate.text = date
                pictureOfTheDayTextView.text = details
            }
        }
    }
    
}
