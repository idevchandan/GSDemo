//
//  GSFavouritePictures.swift
//  GSDemo
//
//  Created by Chandan Kumar on 24/07/22.
//

import Foundation
import UIKit

protocol displaySelectedPicture {
    
    func picturedidSellected(picture: PictureOfDate)
}

class GSFavouritePictures: UIViewController {
    
    @IBOutlet weak var favouritePictureTableView: UITableView!
    
    var favouritePictureList: [PictureOfDate]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "FavouritePictureCell", bundle: nil)
        self.favouritePictureTableView.register(nib, forCellReuseIdentifier: "FavouritePictureCell")
        favouritePictureTableView.dataSource = self
        favouritePictureTableView.delegate = self
        favouritePictureList = [PictureOfDate]()
        favouritePictureTableView.rowHeight = UITableView.automaticDimension
    }
    
    func fetchFavouritePictures() {
        favouritePictureList?.removeAll()
        
        let pictureList = GSStorageService.shareInstance.fetchFavouritePicture()
        for pictureDetails in pictureList {
            let picture = PictureOfDate(title: pictureDetails.title, date: pictureDetails.date, details: pictureDetails.details, imageUrl: pictureDetails.imageUrl)
            favouritePictureList?.append(picture)
        }
        
        favouritePictureTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavouritePictures()
    }
    
}

extension GSFavouritePictures: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouritePictureList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritePictureCell", for: indexPath) as! FavouritePictureCell
        if let pictureDetails = favouritePictureList?[indexPath.row] {
            cell.favouritePicture = pictureDetails
        }
        cell.sellectedPictureDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }

        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.layoutIfNeeded()
        }
    
}

extension GSFavouritePictures: displaySelectedPicture {
    
    func picturedidSellected(picture: PictureOfDate) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pictureOfTheDayVC = storyboard.instantiateViewController(withIdentifier: "GSFavouritePictureController") as! GSFavouritePictureController
        pictureOfTheDayVC.pictureOfTheDay = picture
        self.present(pictureOfTheDayVC, animated: true)
    }
    
    
}
