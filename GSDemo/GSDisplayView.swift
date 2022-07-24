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
            pictureOfTheDayImageView.af.setImage(withURL: URL(string: pictureOfTheDay?.imageUrl ?? "")!)
            pictureOfTheDayTitle.text = pictureOfTheDay?.title
            pictureOfTheDayDate.text = pictureOfTheDay?.date
            pictureOfTheDayTextView.text = pictureOfTheDay?.details
        }
    }

}
