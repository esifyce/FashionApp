//
//  TemplateViewController.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit
import SnapKit
import KMDrawViewSDK

final class TemplateViewController: BaseViewController {
    // MARK: - Property
    var presenter: TemplatePresenterInput
    weak var canvasView: KMDrawView? = nil
    
    // MARK: - Views
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.titleLabel?.textColor = UIColor.mainColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = UIColor.darkGrayColor
        label.text = "Create New Project"
        return label
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["With templates", "Free drawing"])
        segmentControl.tintColor = UIColor.white
        segmentControl.selectedSegmentIndex = 0
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.mainColor,
            .font: UIFont.boldSystemFont(ofSize: 18)
        ]
        
        segmentControl.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.blackColor,
            .font: UIFont.boldSystemFont(ofSize: 18)
        ]
        
        segmentControl.setTitleTextAttributes(normalAttributes, for: .normal)
        
        
        return segmentControl
    }()

    private lazy var divaderView: UIView = {
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
    
    // MARK: - Init
    init(presenter: TemplatePresenterInput,
         kmDrawView: KMDrawView) {
        self.presenter = presenter
        self.canvasView = kmDrawView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defer { presenter.viewDidLoad() }
        setupUI()
        presenter.updateCollection(with: traitCollection)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        segmentControl.selectedSegmentIndex = 0
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        presenter.updateCollection(with: traitCollection)
    }
}

// MARK: - TemplateViewControllerInput
extension TemplateViewController: TemplateViewControllerInput {
    func getCanvas() -> KMDrawView {
        return canvasView!
    }
}

// MARK: - fileprivate TemplateViewController
fileprivate extension TemplateViewController {
    func setupUI() {
        addSubviews()
        setConstraints()
        addTargets()
        configStyle()
    }
    
    func addSubviews() {
        [headerView, collectionView].forEach({ view.addSubview($0) })
        [backButton, titleLabel,
        segmentControl, divaderView].forEach({ headerView.addSubview($0) })
    }
    
    func setConstraints() {
        headerView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(97)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(11)
            make.leading.equalToSuperview().inset(33)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.centerX.equalToSuperview()
        }
        
        segmentControl.snp.makeConstraints { make in
            make.bottom.equalTo(divaderView.snp.top).offset(-9)
            make.width.equalTo(321)
            make.height.equalTo(43)
            make.centerX.equalToSuperview()
        }
        
        divaderView.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.directionalHorizontalEdges.bottom.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
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
        
        segmentControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
        let selectedSegmentIndex = sender.selectedSegmentIndex
        guard selectedSegmentIndex == 1 else { return }
        presenter.goToEditor()
    }
}
