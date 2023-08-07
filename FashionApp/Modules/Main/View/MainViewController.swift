//
//  MainViewController.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit
import SnapKit

final class MainViewController: BaseViewController {
    // MARK: - Property
    var presenter: MainPresenterInput
    
    // MARK: - Init
    
    init(presenter: MainPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Views
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defer { presenter.viewDidLoad() }
        setupUI()
        presenter.updateCollection(with: traitCollection)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        presenter.updateCollection(with: traitCollection)
    }
}

// MARK: - MainViewControllerInput
extension MainViewController: MainViewControllerInput {

}

// MARK: - fileprivate MainViewController
fileprivate extension MainViewController {
    func setupUI() {
        view.backgroundColor =  .white
        
        addSubviews()
        setConstraints()
        configureNavigation()
    }
    
    func addSubviews() {
        [collectionView].forEach({ view.addSubview($0) })
    }
    
    func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureNavigation() {
        title = "Projects"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let infoButton = UIButton(type: .system)
        infoButton.setImage(.Base.infoIcon, for: .normal)
        
        let settingButton = UIButton(type: .system)
        settingButton.setImage(.Base.settingIcon, for: .normal)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: infoButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingButton)
        
        infoButton.addAction(.init(handler: { _ in
            print("Info tapped")
        }), for: .touchUpInside)
        
        settingButton.addAction(.init(handler: { _ in
            print("Setting tapped")
        }), for: .touchUpInside)
    }
}
