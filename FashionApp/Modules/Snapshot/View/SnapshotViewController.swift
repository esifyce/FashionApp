//
//  SnapshotViewController.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit
import SnapKit

final class SnapshotViewController: BaseViewController {
    // MARK: - Property
    private var presenter: SnapshotPresenterInput
    private var skinImage: UIImage?
    
    // MARK: - Init
    init(presenter: SnapshotPresenterInput,
         skinImage: UIImage?) {
        self.presenter = presenter
        self.skinImage = skinImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.Base.backDrawingIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = UIColor.darkGrayColor
        label.text = "Some long name..."
        return label
    }()
    
    private lazy var previewSkinView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.applyFigmaShadow(color: .shadowColor, alpha: 0.1, x: 2, y: 0, blur: 40, spread: 0)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var skinImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = skinImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var saveGalleryButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.mainColor.cgColor
        button.setTitle("Save to Gallery", for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12.0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12.0, bottom: 0, right: 0)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.setImage(UIImage.Base.downloadSkinPreview, for: .normal)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.mainColor.cgColor
        button.setTitle("Share", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12.0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12.0, bottom: 0, right: 0)
        button.setImage(UIImage.Base.shareSkinPreview, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defer { presenter.viewDidLoad() }
        setupUI()
    }
}

// MARK: - SnapshotViewControllerInput
extension SnapshotViewController: SnapshotViewControllerInput {

}

// MARK: - fileprivate SnapshotViewController
fileprivate extension SnapshotViewController {
    func setupUI() {
        addSubviews()
        setConstraints()
        addTargets()
        configStyle()
    }
    
    func addSubviews() {
        [headerView, previewSkinView,
        shareButton, saveGalleryButton].forEach({ view.addSubview($0) })
        [backButton, titleLabel].forEach({ headerView.addSubview($0) })
        
        previewSkinView.addSubview(skinImageView)
    }
    
    func setConstraints() {
        headerView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(11)
            make.leading.equalToSuperview().inset(33)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.centerX.equalToSuperview()
        }
        
        previewSkinView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(16)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
        
        skinImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        saveGalleryButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(66)
            make.trailing.equalTo(shareButton.snp.leading).offset(-16)
            make.height.equalTo(56)
        }
        
        shareButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(66)
            make.width.equalTo(132)
            make.height.equalTo(56)
        }
    }
    
    func configStyle() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
    }
    
    func addTargets() {
        backButton.addAction(UIAction(handler: { [weak self] _ in
            self?.presenter.popViewController()
        }), for: .touchUpInside)
        
        saveGalleryButton.addAction(UIAction(handler: { [weak self] _ in
            guard let image = self?.skinImage else { return }
            self?.presenter.didTapSaveGalleryImage(with: image)
        }), for: .touchUpInside)
        
        shareButton.addAction(UIAction(handler: { [weak self] _ in
            guard let image = self?.skinImage else { return }
            self?.presenter.didTapShareImage(with: image)
        }), for: .touchUpInside)
    }
}
