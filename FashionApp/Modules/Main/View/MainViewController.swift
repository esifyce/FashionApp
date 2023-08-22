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
    
    lazy var divaderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.separatorColor
        return view
    }()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
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
        [divaderView, collectionView].forEach({ view.addSubview($0) })
    }
    
    func setConstraints() {
        divaderView.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.directionalHorizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(divaderView.snp.bottom)
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
//
//        settingButton.addAction(.init(handler: { _ in
//            print("Setting tapped")
//        }), for: .touchUpInside)
        
//        let menuOption1 = UIAction(title: "Subscribe Now") { _ in }
//        let menuOption2 = UIAction(title: "Community") { _ in }
//        let menuOption3 = UIAction(title: "Terms") { _ in }
//        let menuOption4 = UIAction(title: "Contact us") { _ in }
//        let menuOption5 = UIAction(title: "Import") { _ in }
//
//        let menu = UIMenu(title: "", options: .displayInline, children: [menuOption1, menuOption2, menuOption3, menuOption4, menuOption5])
//        settingButton.showsMenuAsPrimaryAction = true
//        settingButton.menu = menu
        
        settingButton.addAction(.init(handler: { [weak self] _ in
            self?.presenter.settingTapped()
        }), for: .touchUpInside)
    }
}
