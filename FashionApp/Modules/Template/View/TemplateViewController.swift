//
//  TemplateViewController.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit
import SnapKit

final class TemplateViewController: BaseViewController {
    // MARK: - Property
    var presenter: TemplatePresenterInput
    
    // MARK: - Init
    init(presenter: TemplatePresenterInput) {
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        presenter.updateCollection(with: traitCollection)
    }
}

// MARK: - TemplateViewControllerInput
extension TemplateViewController: TemplateViewControllerInput {

}

// MARK: - fileprivate TemplateViewController
fileprivate extension TemplateViewController {
    func setupUI() {
        addSubviews()
        setConstraints()
        
        view.backgroundColor = .white
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
}
