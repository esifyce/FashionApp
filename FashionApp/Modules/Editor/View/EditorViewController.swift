//
//  EditorViewController.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit
import SnapKit
import KMDrawViewSDK
import FrameBuilder

enum EditStyle {
    case brush
    case standardBrush
    case clothes
    case menu
}

extension EditorViewController {
    struct Appearance {
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        let topOffset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? -16 : -36
        let trailingOffset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? -10 : -7
        let widthValue: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 241 : 151
        let heightValue: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 700 : CGFloat(666).autoIphoneHeightSize
        let stackClickedIcon: UIImage = UIImage.Base.stackClickedIcon.withRenderingMode(.alwaysOriginal)
        let stackIcon: UIImage = UIImage.Base.stackIcon.withRenderingMode(.alwaysOriginal)
    }
}

final class EditorViewController: BaseViewController {
    // MARK: - Property
    private var presenter: EditorPresenterInput
    private var appearance: Appearance
    private var clothesStack: [EditorViewModel] = []
    private var rendoStack: [EditorViewModel] = []
    
    var keyWindow: UIWindow? {
        UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .last { $0.isKeyWindow }
    }
    
    var isLandscape: Bool {
        UIApplication.shared.isLandscape
    }
    
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
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        return view
    }()
    
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
    
    private lazy var layersView: LayersViewProtocol = {
        let view = LayersView()
        view.delegate = presenter as? LayersViewDelegate
        return view
    }()
    
    private lazy var menuListView: MenuListView = {
       let view = MenuListView()
        view.delegate = presenter as? MenuListViewDelegate
        return view
    }()
    
    private lazy var brushListView: BrushListView = {
        let view = BrushListView()
        view.delegate = presenter as? BrushListViewDelegate
        return view
    }()
    
    private lazy var layerCustomizeView: LayerCustomizeView = {
        let view = LayerCustomizeView()
        view.delegate = presenter as? LayerCustomizeViewDelegate
        return view
    }()
    
    private lazy var canvasView: KMDrawView = {
        let scale = 1.5
        let canvasView = KMDrawView(frame: .init(x: 0, y: 0, width: 200, height: 300))
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.backgroundColor = .clear
        canvasView.renderColor = .blue
        canvasView.isHidden = true
        return canvasView
    }()
        
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defer { presenter.viewDidLoad() }
        setupUI()
        addObservers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layerCustomizeView.layer.cornerRadius = 20
        layerCustomizeView.layer.applyFigmaShadow(color: UIColor.blackShadowColor, alpha: 0.2, x: 8, y: 0, blur: 40, spread: 0)
    }
}

// MARK: - EditorViewControllerInput
extension EditorViewController: EditorViewControllerInput {
    
    func addedItemToManiquen(viewModel: EditorViewModel) {
        clothesStack.removeAll(where: { $0.typeDress == viewModel.typeDress })
        clothesStack.append(viewModel)
        updateSkinClothes()
    }
    
    func snapshotImage() -> UIImage? {
        takeSnapshotOfView(view: skinImageView)
    }

    func showLayerView(with viewModel: [LayerViewModel]) {
        setupLayersViewLayout()
        layersView.update(with: viewModel, isShow: true)
    }
    
    func updateLayerView(with viewModel: [LayerViewModel]) {
        hideBackgroundView()
        layersView.update(with: viewModel, isShow: false)
    }
    
    func hideLayerView() {
        layersView.hide()
    }
    
    func showLayerCustomizeView(with viewModel: LayerViewModel) {
        setupLayerCustomizeViewLayout()
        layerCustomizeView.update(with: viewModel, isShow: true)
    }
    
    func hideLayerCustomizeView() {
        layerCustomizeView.hide()
    }
    
    func toggleLayerButton(_ isClicked: Bool) {
        let image = isClicked ? appearance.stackClickedIcon : appearance.stackIcon
        layersButton.setImage(image ,for: .normal)
    }
    
    func showColorPicker() {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
            
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    func show(with edit: EditStyle) {
        switch edit {
        case .brush:
            brushListView.isHidden = false
            menuListView.isHidden = true
            collectionView.isHidden = true
            controlBar.isHidden = true
            canvasView.isHidden = false
        case .clothes:
            brushListView.isHidden = true
            menuListView.isHidden = true
            collectionView.isHidden = false
            controlBar.isHidden = false
            canvasView.isHidden = true
        case .standardBrush:
            brushListView.isHidden = false
            menuListView.isHidden = true
            collectionView.isHidden = true
            controlBar.isHidden = true
            canvasView.isHidden = false
        case .menu:
            brushListView.isHidden = true
            menuListView.isHidden = false
            collectionView.isHidden = true
            controlBar.isHidden = true
            canvasView.isHidden = false
        }
    }
    
    func setDoneButton(_ enabled: Bool) {
        doneButton.isEnabled = !enabled
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
        menuListView.isHidden = false
        brushListView.isHidden = true
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    func addSubviews() {
        defer {
            view.addSubview(canvasView)
            view.bringSubviewToFront(canvasView)
        }
        [skinImageView, headerView,
         layersButton, collectionView,
         controlBar, menuListView, brushListView].forEach({ view.addSubview($0) })
        
        [backButton, backTitle,
        stepStackView, doneButton].forEach({ headerView.addSubview($0) })
        
        [headerView, layersButton,
         collectionView, controlBar, menuListView, brushListView].forEach({ view.bringSubviewToFront($0) })
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
        
        canvasView.buildFrame(FrameBuilder()
                                .centerXToCenterX(ofView: view)
                                .centerYToCenterY(ofView: view, offset: -150)
                                .height(583)
                                .width(200)
        )
    }
    
    func configStyle() {
        view.backgroundColor = .white
    }
    
    func addTargets() {
        backButton.addAction(UIAction(handler: { [weak self] _ in
            self?.presenter.popViewController()
        }), for: .touchUpInside)
        
        leftStepButton.addAction(UIAction(handler: { [weak self] _ in
            guard let popClothes = self?.clothesStack.popLast() else { return }
            self?.rendoStack.append(popClothes)
            self?.updateSkinClothes()
        }), for: .touchUpInside)
        
        rightStepButton.addAction(UIAction(handler: { [weak self] _ in
            guard let popClothes = self?.rendoStack.popLast() else { return }
            self?.clothesStack.append(popClothes)
            self?.updateSkinClothes()
        }), for: .touchUpInside)
        
        doneButton.addAction(UIAction(handler: { [weak self] _ in
            self?.presenter.doneButtonTapped()
        }), for: .touchUpInside)
        
        layersButton.addAction(UIAction(handler: { [weak self] _ in
            self?.presenter.layerButtonTapped()
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
        changeLayersViewLayout()
    }
    
    func changeLayersViewLayout() {
        guard let layersView = self.layersView as? UIView else { return }
        
        if layersView.isDescendant(of: view) {
            layersView.snp.remakeConstraints { make in
                make.top.equalTo(headerView.snp.bottom).offset(appearance.topOffset)
                make.trailing.equalTo(layersButton.snp.leading).offset(appearance.trailingOffset)
                make.width.equalTo(appearance.widthValue)
                make.height.equalTo(appearance.heightValue)
            }
        }
    }
}

// MARK: - LayersViewsLayout
private extension EditorViewController {
    func setupLayersViewLayout() {
        guard let layersView = self.layersView as? UIView else { return }
        view.addSubview(layersView)
        layersView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(appearance.topOffset)
            make.trailing.equalTo(layersButton.snp.leading).offset(appearance.trailingOffset)
            make.width.equalTo(appearance.widthValue)
            make.height.equalTo(appearance.heightValue)
        }
    }
    
    func setupLayerCustomizeViewLayout() {
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            keyWindow?.addSubview(backgroundView)
            backgroundView.frame = view.bounds
            UIView.animate(withDuration: 0.2) {
                self.backgroundView.alpha = 1.0
            }
            keyWindow?.addSubview(layerCustomizeView)
            layerCustomizeView.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(0.68)
                make.width.equalToSuperview().multipliedBy(0.7)
            }
        } else {
            view.addSubview(layerCustomizeView)
            layerCustomizeView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(110)
                make.height.equalTo(573)
                make.width.equalTo(393)
            }
        }
    }
    
    func hideBackgroundView() {
        UIView.animate(withDuration: 0.2) {
            self.backgroundView.alpha = 0.0
        } completion: { _ in
            self.backgroundView.removeFromSuperview()
        }
    }
    
    func takeSnapshotOfView(view: UIView) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { context in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        return image
    }
    
    func updateSkinClothes() {
        skinImageView.subviews.forEach({ $0.removeFromSuperview() })
        clothesStack.forEach({ clothes in
            let imageView = UIImageView()
            imageView.image = UIImage(named: clothes.nameDress)
            skinImageView.addSubview(imageView)
            let width = skinImageView.frame.width
            let height = skinImageView.frame.height
            imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        })
    }
}

// MARK: - UIColorPickerViewControllerDelegate
extension EditorViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        dismiss(animated: true)
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        brushListView.update(with: color)
        canvasView.renderColor = color
    }
}
