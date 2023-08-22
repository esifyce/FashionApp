//
//  EditorViewController.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit
import SnapKit

extension EditorViewController {
    struct Appearance {
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        let topOffset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? -16 : -36
        let trailingOffset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? -10 : -7
        let widthValue: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 241 : 151
        let heightValue: CGFloat = 620
        let stackClickedIcon: UIImage = UIImage.Base.stackClickedIcon.withRenderingMode(.alwaysOriginal)
        let stackIcon: UIImage = UIImage.Base.stackIcon.withRenderingMode(.alwaysOriginal)
    }
}

final class EditorViewController: BaseViewController {
    // MARK: - Property
    private var presenter: EditorPresenterInput
    private var appearance: Appearance
    private var stackIsClicked: Bool = false
    // MARK: - Init
    
    init(presenter: EditorPresenterInput) {
        self.presenter = presenter
        self.appearance = Appearance()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    
    private lazy var headerView: UIView = {
       let headerView = UIView()
        headerView.backgroundColor = .white
        return headerView
    }()
    
    private lazy var leftStepButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.Base.leftStepIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    private lazy var rightStepButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.Base.rightStepIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    private lazy var stepStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftStepButton, rightStepButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.Base.backDrawingIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    private lazy var backTitle: UILabel = {
        let label = UILabel()
        label.text = "Some long file name"
        label.textColor = UIColor.darkGrayColor
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 1
        return label
    }()

    private lazy var skinImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = .Base.skinIcon2
        return imageView
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.titleLabel?.textColor = .mainColor
        button.titleLabel?.font = .systemFont(ofSize: 18)
        return button
    }()
    
    private lazy var layersButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.Base.stackIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let controlBar: StatusBar = {
        StatusBar()
    }()
    
    private lazy var layersView: LayersView = {
       LayersView()
    }()
    
    private lazy var menuListView: MenuListView = {
       MenuListView()
    }()
    
    private lazy var brushListView: BrushListView = {
        BrushListView()
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defer { presenter.viewDidLoad() }
        setupUI()
        addObservers()
    }
}

// MARK: - EditorViewControllerInput
extension EditorViewController: EditorViewControllerInput {
    func addedItemToManiquen(dressName: String) {
        skinImageView.subviews.forEach({ $0.removeFromSuperview() })
        let imageView = UIImageView()
        imageView.image = UIImage(named: dressName)
        skinImageView.addSubview(imageView)
        let width = skinImageView.frame.width
        let height = skinImageView.frame.height
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
}

// MARK: - fileprivate EditorViewController
fileprivate extension EditorViewController {
    func setupUI() {
        addSubviews()
        setConstraints()
        configStyle()
        addTargets()
        
        let temp: [UIImage.Clothes] = [.hair, .pants, .shoes, .dress]
        
        var viewModel: [StatusBarViewModel] = []
        
        temp.enumerated().forEach { index, element in
            viewModel.append(StatusBarViewModel(name: element.description, id: index))
        }
        
        controlBar.setup(models: viewModel, index: .zero)
        collectionView.isHidden = true
        controlBar.isHidden = true
        menuListView.isHidden = true
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    func addSubviews() {
        [skinImageView, headerView,
         layersButton, collectionView,
         controlBar, layersView,
         menuListView, brushListView].forEach({ view.addSubview($0) })
        
        [backButton, backTitle,
        stepStackView, doneButton].forEach({ headerView.addSubview($0) })
        
        [headerView, layersButton,
         collectionView, controlBar,
         layersView, menuListView, brushListView].forEach({ view.bringSubviewToFront($0) })
    }
    
    func setConstraints() {
        skinImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(583)
            make.width.equalTo(390)
        }
        
        headerView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(70)
        }
        
        layersButton.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(4)
            make.trailing.equalToSuperview().inset(16)
            make.height.width.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(100)
            make.bottom.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
        
        backTitle.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).offset(4)
            make.trailing.equalTo(stepStackView.snp.leading).offset(-24)
            make.centerY.equalTo(backButton)
        }
        
        stepStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(96)
        }
        
        leftStepButton.snp.makeConstraints { make in
            make.height.width.equalTo(44)
        }
        
        rightStepButton.snp.makeConstraints { make in
            make.height.width.equalTo(44)
        }
        
        doneButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        controlBar.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(36)
            make.height.equalTo(45)
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        layersView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(appearance.topOffset)
            make.trailing.equalTo(layersButton.snp.leading).offset(appearance.trailingOffset)
            make.width.equalTo(appearance.widthValue)
            make.height.equalTo(appearance.heightValue.autoIphoneHeightSize)
        }
        
        menuListView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(44 * 3 + 16 * 2)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(44)
        }
        
        brushListView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(44 * 5 + 16 * 4)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(44)
        }
    }
    
    func configStyle() {
        view.backgroundColor = .white
    }
    
    func addTargets() {
        backButton.addAction(UIAction(handler: { [weak self] _ in
            self?.presenter.popViewController()
        }), for: .touchUpInside)
        
        leftStepButton.addAction(UIAction(handler: { _ in
            print("Did tap left")
        }), for: .touchUpInside)
        
        rightStepButton.addAction(UIAction(handler: { _ in
            print("Did tap right")
        }), for: .touchUpInside)
        
        doneButton.addAction(UIAction(handler: { [weak self] _ in
            self?.presenter.popViewController()
        }), for: .touchUpInside)
        
        layersButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            self.stackIsClicked.toggle()
            self.layersButton.setImage(self.stackIsClicked
                                        ? self.appearance.stackClickedIcon
                                        : self.appearance.stackIcon,
                                        for: .normal)
            self.layersView.show(self.stackIsClicked)
        }), for: .touchUpInside)
        
        controlBar.didTapCallBack = { [weak self] index in
            self?.presenter.updateCollectionByCategory(index: index)
        }
    }
    
    @objc func orientationChanged() {
        guard appearance.isIpad else { return }
        
        var heightValue = appearance.heightValue
        
        switch UIDevice.current.orientation {
        case .portrait, .portraitUpsideDown:
            heightValue = heightValue.autoIphoneWidthSize
        case .landscapeLeft, .landscapeRight:
            heightValue = heightValue.autoIpadHeightLandscapeSize
        default:
            break
        }
        
        layersView.snp.remakeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(appearance.topOffset)
            make.trailing.equalTo(layersButton.snp.leading).offset(appearance.trailingOffset)
            make.width.equalTo(appearance.widthValue)
            make.height.equalTo(heightValue)
        }
    }
}
