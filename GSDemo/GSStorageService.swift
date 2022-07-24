//
//  GSStorageService.swift
//  GSDemo
//
//  Created by Chandan Kumar on 24/07/22.
//

import UIKit
import CoreData

class GSStorageService {
    
    static let shareInstance = GSStorageService()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveFavouritePicture(title: String, date: String, details: String, imageUrl: String) {
        let favouritePictureInstance = FavouritePicture(context: context)
        favouritePictureInstance.title = title
        favouritePictureInstance.date = date
        favouritePictureInstance.details = details
        favouritePictureInstance.imageUrl = imageUrl
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchFavouritePicture() -> [FavouritePicture] {
        var fetchingFavouritePicture = [FavouritePicture]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouritePicture")
        
        do {
            fetchingFavouritePicture = try context.fetch(fetchRequest) as! [FavouritePicture]
        } catch {
            print("Error while fetching Favourite Picture")
        }
        
        return fetchingFavouritePicture
    }
    
    func checkPictureExistsExists(date: String) -> Bool {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouritePicture")
        fetchRequest.predicate = NSPredicate(format: "date == %@" ,date)

        var results: [NSManagedObject] = []

        do {
            results = try context.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        return results.count > 0

    }

}
