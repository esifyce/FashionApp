//
//  EditorViewControllerInput.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

protocol EditorViewControllerInput: AnyObject {
    func addedItemToManiquen(viewModel: EditorViewModel)
    func showLayerView(with viewModel: [LayerViewModel])
    func hideLayerView()
    func updateLayerView(with viewModel: [LayerViewModel])
    func showLayerCustomizeView(with viewModel: LayerViewModel)
    func hideLayerCustomizeView()
    func toggleLayerButton(_ isClicked: Bool)
    func showColorPicker()
    func dismiss()
    func setDoneButton(_ enabled: Bool)
    func show(with edit: EditStyle)
    func snapshotImage() -> UIImage?
    func showConfigPen(with viewModel: BrushViewModel)
    func hidePencilView()
    func configurePen(with opacity: Float, size: Float)
}
