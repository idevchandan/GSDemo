//
//  FavouritePictureCell.swift
//  GSDemo
//
//  Created by Chandan Kumar on 24/07/22.
//

import UIKit

class FavouritePictureCell: UITableViewCell {
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var sellectedPictureDelegate: displaySelectedPicture?
    
    var favouritePicture: PictureOfDate? {
        didSet {
            if let title = favouritePicture?.title, let date = favouritePicture?.date, let imageURL = favouritePicture?.imageUrl {
                self.titleLabel.text = title
                self.dateLabel.text = date
                self.pictureView.af.setImage(withURL: URL(string: imageURL)!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func showFavouritePictureDetails(_ sender: Any) {
        sellectedPictureDelegate?.picturedidSellected(picture: favouritePicture!)
    }
}
