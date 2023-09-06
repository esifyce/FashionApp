//
//  BrushViewController.swift
//  FashionApp
//
//  Created by Krasivo on 13.08.2023.
//

//import UIKit
//import KMDrawViewSDK
//import SnapKit
//
//final class BrushViewController: UIViewController {
import UIKit
//import KMDrawViewSDK
import SnapKit
import Firebase
import FirebaseStorage

final class BrushViewController: UIViewController {
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
//        let storage = Storage.storage()
//        let imageRef = storage.reference().child("images/tortuga.jpg")
//
//        imageRef.getData(maxSize: 1 * 1024 * 1024) { [weak self] data, error in
//            if let error {
//                print(error)
//                return
//            }
//
//            guard let data else {
//                print("No Data")
//                return
//            }
//
//            let image = UIImage(data: data)
//            DispatchQueue.main.async {
//                self?.imageView.image = image
//            }
//        }
        
//        FirebaseManger.shared.getClothes(clothes: .shoes, from: .clothes) { [weak self] urlArray in
//            print(urlArray)
//            print("End")
//        }
    }
    
    func setupUI() {
        addSubviews()
        makeConstraints()
    }
    
    func addSubviews() {
        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
    }
}
