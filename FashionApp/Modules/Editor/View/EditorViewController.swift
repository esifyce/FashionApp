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

final class EditorViewController: BaseViewController, UIPopoverPresentationControllerDelegate {
    // MARK: - Property
    private var presenter: EditorPresenterInput
    private var appearance: Appearance
    weak var canvasView: KMDrawView? = nil
    
    private var layers: [UIImage] = []
    
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
    
    // MARK: - Views
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        return view
    }()
    
    private lazy var containerView: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
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
        imageView.image = .Mannequin.skinIcon2
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var layerImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
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
    
    private lazy var clothesView: ClothesView = {
        let view = ClothesView()
        view.delegate = presenter as? ClothesViewDelegate
        return view
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
    
    private lazy var pencilView: PencilView = {
        let view = PencilView()
        view.delegate = presenter as? PencilViewDelegate
        return view
    }()
        
    // MARK: - Init
    
    init(presenter: EditorPresenterInput,
         kmDrawView: KMDrawView) {
        self.presenter = presenter
        self.canvasView = kmDrawView
        self.appearance = Appearance()
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
        addObservers()
        addTouches()
        self.canvasView?.radius = 34
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layerCustomizeView.layer.cornerRadius = 20
        layerCustomizeView.layer.applyFigmaShadow(color: UIColor.blackShadowColor, alpha: 0.2, x: 8, y: 0, blur: 40, spread: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        canvasView?.clear()
        canvasView?.renderColor = .blue
    }
}

// MARK: - EditorViewControllerInput
extension EditorViewController: EditorViewControllerInput {
    
    func configurePen(with opacity: Float, size: Float) {
        canvasView?.opacity = opacity
        canvasView?.radius = size
    }
    
    func addedItemToManiquen(viewModel: EditorViewModel) {
        var clothesStack = presenter.getClothesStack()
        clothesStack.removeAll(where: { $0.typeDress == viewModel.typeDress })
        clothesStack.append(viewModel)
        updateSkinClothes(clothesStack)
    }
    
    func snapshotImage() -> UIImage? {
        guard let drawImage = canvasView?.image(), let skinImage = takeSnapshotOfView(view: skinImageView) else { return nil }
        return overlayImages(backgroundImage: skinImage, overlayImage: drawImage)
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
    
    func showConfigPen(with viewModel: BrushViewModel) {
        if viewModel.type == .erasse {
            pencilView.isHidden = true
        } else {
            pencilView.isHidden = false
            pencilView.configure(with: viewModel)
        }
 
        changeBrushType(with: viewModel.type)
        brushListView.updateBrush(with: viewModel)
    }
    
    func hidePencilView() {
        pencilView.isHidden = true
    }
    
    func showColorPicker() {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.modalPresentationStyle = .popover
        picker.preferredContentSize = CGSize(width: 200, height: 100)
        if let presController = picker.presentationController {
            presController.delegate = self
        }
        present(picker, animated: true, completion: nil)
        if let popoverController = picker.popoverPresentationController {
            popoverController.permittedArrowDirections = .down
            popoverController.sourceView = brushListView.closeButton
            popoverController.sourceRect = brushListView.bounds
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIDevice.current.userInterfaceIdiom == .pad ? .popover : .none
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
            clothesView.isHidden = true
            canvasView?.isHidden = false
            brushListView.setCustomBrush()
        case .clothes:
            brushListView.isHidden = true
            menuListView.isHidden = true
            collectionView.isHidden = false
            clothesView.isHidden = false
            canvasView?.isHidden = true
        case .standardBrush:
            brushListView.isHidden = false
            menuListView.isHidden = true
            collectionView.isHidden = true
            clothesView.isHidden = true
            canvasView?.isHidden = false
        case .menu:
            brushListView.isHidden = true
            menuListView.isHidden = false
            collectionView.isHidden = true
            clothesView.isHidden = true
            canvasView?.isHidden = false
        }
    }
    
    func setDoneButton(_ enabled: Bool) {
        doneButton.isEnabled = !enabled
    }
    
    func changeBrushType(with type: BrushType) {
      //  canvasView?.resetParams()
        switch type {
        case .pen:
            canvasView?.brushType = ESBrushTypePencil
            canvasView?.blendType = ESLayerBlendTypeMultiply
            canvasView?.radius = 5
            break
        case .pencil:
            canvasView?.brushType = ESBrushTypePencil
            canvasView?.blendType = ESLayerBlendTypeDissolution
            canvasView?.radius = 15
        case .erasse:
            canvasView?.brushType = ESBrushTypeNormal
            canvasView?.blendType = ESLayerBlendTypeErase
            canvasView?.radius = 100
        case .marker:
            canvasView?.brushType = ESBrushTypeSmudge
            canvasView?.blendType = ESLayerBlendTypeMultiply
            canvasView?.minRadius = 0.08
            canvasView?.maxRadius = 1
            canvasView?.sensitivity = 49
            canvasView?.speedSencitive = 0.41
            canvasView?.minFlow = 0.02
            canvasView?.maxFlow = 1
            canvasView?.radius = 25
            break
        case .flomaster:
            canvasView?.brushType = ESBrushTypeSmudge
            canvasView?.blendType = ESLayerBlendTypeMultiply
            canvasView?.radius = 50
            canvasView?.smoothEnabled = true
            break
        case .texture:
            self.canvasView?.resetParams()
            self.canvasView?.brushType = ESBrushTypeNormal
            self.canvasView?.blendType = ESLayerBlendTypeNormal
            self.canvasView?.textureImages = [UIImage(named: "Texture.png") as Any]
            self.canvasView?.pointsDistanceEnabled = true
            self.canvasView?.pointsDistance = 0.01
            self.canvasView?.smoothEnabled = true
            self.canvasView?.minRadius = 0.08
            self.canvasView?.maxRadius = 1
            self.canvasView?.sensitivity = 49
            self.canvasView?.speedSencitive = 0.41
            self.canvasView?.minFlow = 0.02
            self.canvasView?.maxFlow = 1
            self.canvasView?.radius = 25
        }
    }
}

// MARK: - fileprivate EditorViewController
fileprivate extension EditorViewController {
    func setupUI() {
        addSubviews()
        setConstraints()
        configStyle()
        addTargets()
        
        let temp: [Clothes] = [.hair, .pants, .shoes, .dress]
        var viewModel: [StatusBarViewModel] = []
        
        temp.enumerated().forEach { index, element in
            viewModel.append(StatusBarViewModel(name: element.description, id: index))
        }
        
        clothesView.categoryClothes.setup(models: viewModel, index: .zero)
        [collectionView, clothesView, brushListView, pencilView, canvasView!].forEach({ $0.isHidden = true })
        [menuListView].forEach({ $0.isHidden = false })
        
        canvasView?.delegate = self
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    func addSubviews() {
        guard let canvasView else { return }
        [skinImageView, layerImageView, canvasView].forEach({ containerView.addSubview($0) })
        [headerView,
         containerView,
         layersButton, collectionView,
         clothesView, menuListView,
         pencilView, brushListView].forEach({ view.addSubview($0) })
        
        [backButton, backTitle,
        stepStackView, doneButton].forEach({ headerView.addSubview($0) })
        
        [headerView, layersButton,
         collectionView, clothesView, menuListView,
         brushListView].forEach({ view.bringSubviewToFront($0) })
    }
    
    func setConstraints() {
        guard let canvasView else { return }
        
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
        
        clothesView.snp.makeConstraints { make in
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
        
        pencilView.snp.makeConstraints { make in
            make.height.equalTo(254)
            make.directionalHorizontalEdges.bottom.equalToSuperview()
        }
        
        brushListView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(44 * 5 + 16 * 4)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(44)
        }
        
        containerView.buildFrame(
            FrameBuilder()
                .x(0)
                .y(0)
                .height(583)
                .width(390)
        )
        
        skinImageView.frame = containerView.bounds
        layerImageView.frame = containerView.bounds
        canvasView.frame = skinImageView.bounds
    }
    
    func configStyle() {
        view.backgroundColor = .white
    }
    
    func addTargets() {
        backButton.addAction(UIAction(handler: { [weak self] _ in
            self?.presenter.popViewController()
        }), for: .touchUpInside)
        
        leftStepButton.addAction(UIAction(handler: { [weak self] _ in
            self?.leftStepButtonTapped()
        }), for: .touchUpInside)
        
        rightStepButton.addAction(UIAction(handler: { [weak self] _ in
            self?.rightStepButtonTapped()
        }), for: .touchUpInside)
        
        doneButton.addAction(UIAction(handler: { [weak self] _ in
            self?.presenter.doneButtonTapped()
        }), for: .touchUpInside)
        
        layersButton.addAction(UIAction(handler: { [weak self] _ in
            self?.newLayerTapped()
            //self?.presenter.layerButtonTapped()
        }), for: .touchUpInside)
        
        clothesView.categoryClothes.didTapCallBack = { [weak self] index in
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
    
    func leftStepButtonTapped() {
       guard let popClothes = self.presenter.popFromClothes(),
            let canvasView else { return }

        var rendoStack = self.presenter.getRendoStack()
        rendoStack.append(popClothes)
        presenter.setRendoStack(with: rendoStack)
        updateSkinClothes(presenter.getClothesStack())

        if canvasView.canUndo() {
            canvasView.undo()
        }
        
        canvasView.clear()
    }
    
    func rightStepButtonTapped() {
        guard  let popClothes = self.presenter.popFromRendoClothes(),
               let canvasView else { return }
        var clothesStack = self.presenter.getClothesStack()
        clothesStack.append(popClothes)
        updateSkinClothes(clothesStack)
        
        if canvasView.canRedo() {
            canvasView.redo()
        }
    }
    
    func newLayerTapped() {
        guard let canvasView else { return }
        layers.append(canvasView.image())
        canvasView.clear()
        updateLayers()
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
    
    func overlayImages(backgroundImage: UIImage, overlayImage: UIImage) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(backgroundImage.size, false, 0.0)
        
        backgroundImage.draw(in: CGRect(x: 0, y: 0, width: backgroundImage.size.width, height: backgroundImage.size.height))
        overlayImage.draw(in: CGRect(x: 0, y: 0, width: backgroundImage.size.width, height: backgroundImage.size.height))
        
        let mergedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return mergedImage
    }
    
    func updateSkinClothes(_ clothesStack: [EditorViewModel]) {
        skinImageView.subviews.forEach({ $0.removeFromSuperview() })
        clothesStack.forEach({ clothes in
            let imageView = UIImageView()
            imageView.image = UIImage(named: clothes.nameDress)
            imageView.isUserInteractionEnabled = true
            skinImageView.addSubview(imageView)
            let width = skinImageView.frame.width
            let height = skinImageView.frame.height
            imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        })
        presenter.setClothesStack(with: clothesStack)
    }
    
    func updateLayers() {
        layerImageView.subviews.forEach({ $0.removeFromSuperview() })
        layers.forEach({ layer in
            let imageView = UIImageView()
            imageView.image = layer
            imageView.isUserInteractionEnabled = true
            layerImageView.addSubview(imageView)
            let width = layerImageView.frame.width
            let height = layerImageView.frame.height
            imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        })
    }
}

// MARK: - Add Touches Extension
private extension EditorViewController {
    func addTouches() {
        skinImageView.transform = .identity
        let scaleGesture = UIPinchGestureRecognizer(target: self, action: #selector(handleScale(_:)))
        let moveGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        moveGesture.minimumNumberOfTouches = 2
        moveGesture.maximumNumberOfTouches = 2
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotate(_:)))
        
        skinImageView.addGestureRecognizer(scaleGesture)
        skinImageView.addGestureRecognizer(moveGesture)
        skinImageView.addGestureRecognizer(rotateGesture)
    }
    
    @objc func handleScale(_ sender: UIPinchGestureRecognizer) {
        var onePoint: CGPoint = .zero
        var twoPoint: CGPoint = .zero
        var anchorPoint: CGPoint = .zero
        
        if sender.state == .began {
            if sender.numberOfTouches == 2 {
                onePoint = sender.location(ofTouch: 0, in: skinImageView)
                twoPoint = sender.location(ofTouch: 1, in: skinImageView)
            }
            anchorPoint.x = (onePoint.x + twoPoint.x) / 2 / skinImageView.bounds.size.width
            anchorPoint.y = (onePoint.y + twoPoint.y) / 2 / skinImageView.bounds.size.height
            skinImageView.setAnchorPoint(anchorPoint: anchorPoint)
        }
        
        if sender.numberOfTouches == 2 && sender.state == .changed {
            skinImageView.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
        }
    }
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        if !sender.isEnabled {
            return
        }
        
        if sender.numberOfTouches == 2 && sender.state == .changed {
            let translation = sender.translation(in: skinImageView.superview)
            skinImageView.center = CGPoint(x: skinImageView.center.x + translation.x, y: skinImageView.center.y + translation.y)
            sender.setTranslation(.zero, in: skinImageView.superview)
        }
    }
    
    @objc func handleRotate(_ sender: UIRotationGestureRecognizer) {
        guard sender.view != nil else { return }
        
        if sender.state == .began || sender.state == .changed {
            sender.view?.transform = sender.view!.transform.rotated(by: sender.rotation)
            sender.rotation = 0
        }
    }
}

// MARK: - UIColorPickerViewControllerDelegate
extension EditorViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        dismiss(animated: true)
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        brushListView.update(with: color)
        canvasView?.renderColor = color
        pencilView.updateColor(with: color)
    }
}

// MARK: - KMDrawViewDelegate
extension EditorViewController: KMDrawViewDelegate {
    
    func drawView(_ drawView: KMDrawView!, didDrawBegin point: CGPoint) {
        print("drawBegin \(point)")
    }
    
    func drawView(_ drawView: KMDrawView!, didDrawEnd point: CGPoint) {
        drawView.markAction()
    }
}
