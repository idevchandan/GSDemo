//
//  GSNetworkService.swift
//  GSDemo
//
//  Created by Chandan Kumar on 24/07/22.
//

import Foundation
import UIKit

class GSNetworkService: NSObject {
    
    let APOD_API_URL_HOST = "https://api.nasa.gov/planetary/apod"
    let API_KEY = "gnfLdIxfMxEdWuB8wf8oId5HNWrjyQtKEwN0pXa9"
    
    func getPictireOfDate(date: String, onSuccess : @escaping(PictureOfDate) -> Void, onFailure : @escaping(Error?) -> Void) {
        let urlString = APOD_API_URL_HOST + "?api_key=\(API_KEY)&date=\(date)&concept_tags=True"
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
                
        //startLoadingIndicator()
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                //self.dismissLoadingIndicator()
                onFailure(error)
            } else {
                guard let data = data else {
                    // handle empyy data
                    return
                }
                do {
                    let pictureOfDateResponse = try JSONDecoder().decode(PictureOfDate.self, from: data)
                    onSuccess(pictureOfDateResponse)
                } catch let error as NSError {
                    onFailure(error)
                }
                //self.dismissLoadingIndicator()
            }
        }
        dataTask.resume()
    }
    
    func showNetworkAlert() {
        DispatchQueue.main.async {
            let topVC = self.getTopViewController()
            let alert: UIAlertController =  UIAlertController(title: NSLocalizedString("Network Error!", comment: ""), message: NSLocalizedString("Please enable network connection and retry!", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (alertAction) in
                topVC?.dismiss(animated: true
                              , completion: nil)
            }))
            
            topVC?.present(alert, animated: true, completion:nil)
        }
    }
    
    func getTopViewController() -> UIViewController? {
        var topViewController: UIViewController?
        if let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as? SceneDelegate {
            let vc = sceneDelegate.window!.rootViewController
            if(vc is UINavigationController){
                topViewController = (vc as! UINavigationController).visibleViewController
                
            } else if (vc != nil){
                topViewController = vc
            }
            return topViewController
        }
        return nil
    }
    
}
