//
//  SnapshotRouter.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

final class SnapshotRouter {
    weak var view: UIViewController?
}

// MARK: - SnapshotRouterInput
extension SnapshotRouter: SnapshotRouterInput {
    func popViewController() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func saveGallery(with image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
    }
    
    func shareImage(with image: UIImage) {
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.overrideUserInterfaceStyle = .light
        activityViewController.popoverPresentationController?.sourceView = self.view?.view
        
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        view?.present(activityViewController, animated: true, completion: nil)
    }
}
