//
//  NewsDetailScreenPresenter.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit


final class EditorPresenter {
    weak var view: EditorViewControllerInput?
    private let router: EditorRouterInput
    private let interactor: EditorInteractorInput
    private let collectionManager: EditorCollectionManagerProtocol
    private var stackIsClicked: Bool = false
    private var layerViewModels: [LayerViewModel] = []
    private var index: Int = 0
    
    private var clothesStack: [EditorViewModel] = []
    private var rendoStack: [EditorViewModel] = []
    
    init(router: EditorRouterInput,
         interactor: EditorInteractorInput,
         collectionManager: EditorCollectionManagerProtocol) {
        self.router = router
        self.interactor = interactor
        self.collectionManager = collectionManager
    }
}

// MARK: - EditorPresenterInput
extension EditorPresenter: EditorPresenterInput {
    func viewDidLoad() {}
    
    func popViewController() {
        router.popViewController()
    }
    
    func updateCollectionByCategory(index: UIImage.Clothes) {
        let clothes = index.getClothes
        let previewClothes = index.previewClothes
         
         let viewModel = zip(clothes, previewClothes).map { (name, preview) in
             EditorViewModel(nameDress: name, typeDress: index, previewDress: preview, isSelectedImage: false)
         }
         
         collectionManager.displaySquareEditors(viewModel)
    }
    
    func layerButtonTapped() {
        stackIsClicked.toggle()
        view?.toggleLayerButton(stackIsClicked)
        view?.setDoneButton(stackIsClicked)
        
        if stackIsClicked {
            if layerViewModels.isEmpty {
                layerViewModels = interactor.getLayerViewModels()
            }
            view?.showLayerView(with: layerViewModels)
        } else {
            view?.hideLayerView()
        }
    }
    
    func doneButtonTapped() {
        guard let image = view?.snapshotImage() else { return }
        interactor.saveObject(image: image , model: .init(clothes: clothesStack, name: "skin\(UUID().uuidString)"))
        //router.shareSkinImage(with: view?.snapshotImage())
    }
    
    func getClothesStack() -> [EditorViewModel] {
        clothesStack
    }
    
    func getRendoStack() -> [EditorViewModel] {
        rendoStack
    }
    
    func setClothesStack(with stack: [EditorViewModel]) {
        clothesStack = stack
    }
    
    func setRendoStack(with stack: [EditorViewModel]) {
        rendoStack = stack
    }
    
    func popFromClothes() -> EditorViewModel? {
        clothesStack.popLast()
    }
    
    func popFromRendoClothes() -> EditorViewModel? {
        rendoStack.popLast()
    }
}

// MARK: - private EditorPresenter
private extension EditorPresenter {
}

// MARK: - EditorCollectionManagerDelegate
extension EditorPresenter: EditorCollectionManagerDelegate {
    func addedItemToManiquen(viewModel: EditorViewModel) {
        view?.addedItemToManiquen(viewModel: viewModel)
    }
}

// MARK: - LayersViewDelegate
extension EditorPresenter: LayersViewDelegate {
    func didSelect(at index: Int) {
        self.index = index
        guard let viewModel = layerViewModels[safe: index] else { return }
        view?.showLayerCustomizeView(with: viewModel)
    }
}

// MARK: - LayersCustomizeViewDelegate
extension EditorPresenter: LayerCustomizeViewDelegate {
    func didTapClose(with viewModel: LayerViewModel) {
        layerViewModels[index] = viewModel
        view?.updateLayerView(with: layerViewModels)
    }
}

// MARK: - BrushListViewDelegate
extension EditorPresenter: BrushListViewDelegate {
    func colorPickerTapped() {
        view?.showColorPicker()
    }
    
    func closeTapped() {
        view?.show(with: .menu)
    }
}

// MARK: - MenuListViewDelegate
extension EditorPresenter: MenuListViewDelegate {
    func clothesTapped() {
        view?.show(with: .clothes)
    }
    
    func customBrushTapped() {
        view?.show(with: .brush)
    }
    
    func standartBrushTapped() {
        view?.show(with: .standardBrush)
    }
}

