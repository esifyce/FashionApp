//
//  BrushViewController.swift
//  FashionApp
//
//  Created by Krasivo on 13.08.2023.
//

//import UIKit
//import KMDrawViewSDK
//import SnapKit
//
//final class BrushViewController: UIViewController {    
//    private lazy var drawView: KMDrawView = {
//        let scale = 1.5;
//        let drawView = KMDrawView(frame: CGRectMake(0, 0,
//                                                    nearbyint(CGRectGetWidth(self.view.frame) * scale),
//                                                    nearbyint(CGRectGetHeight(self.view.frame) * scale)));
//        return drawView
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        view.addSubview(drawView)
//        drawView.backgroundColor = .white
//        drawView.frame = view.frame
//        drawView.delegate = self
//        setupUI()
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//    }
//    
//    func setupUI() {
//        drawView.resetParams()
//        drawView.brushType = ESBrushTypeNormal
//        drawView.blendType = ESLayerBlendTypeDissolution
//        drawView.pointsDistanceEnabled = true
//        drawView.pointsDistance = 0.01
//        drawView.autoMark = true
//        drawView.needCancelLine = true
//        drawView.repeatedlyRenderEnabled = false
//        drawView.smoothEnabled = true
//        drawView.colorFul = true
//        drawView.textureImages = [UIImage(named: "test3.jpg") as Any]
//        drawView.minRadius = 0.08
//        drawView.maxRadius = 1
//
//        drawView.sensitivity = 49
//        drawView.speedSencitive = 0.41
//
//        drawView.minFlow = 0.02
//        drawView.maxFlow = 1
//
//        drawView.radius = 20
////        let brushName = "lushkin"
////        let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
////                let fileURL = documentDirectory.appendingPathComponent("\(brushName).kbr")
////        var version: Int32 = 200
////        let brushParams = KMBrushManager.params(of: drawView)
////        KMBrushManager.saveParams(brushParams, version: version, withName: brushName, inPath: fileURL.absoluteString)
////        print(fileURL.path)
////        KMBrushManager.brushes(withKBRPath: fileURL.path, version: &version)
////
////
////        let brushName = "xxxx"
////        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory,
////        .userDomainMask, true).last?.appending("/\(brushName).kbr");
////        KMBrushManager.saveParams(with: drawView,
////                                     withName: brushName,
////                                     inPath: path)
////        let igor = KMBrushManager.brushes(withKBRPath: path, version: nil)
////        print(igor)
////
//    }
//}
//
//extension BrushViewController: KMDrawViewDelegate {
//    func drawView(_ drawView: KMDrawView, shouldDrawBegin point: CGPoint) -> CGPoint {
//        return point
//    }
//
//    func drawView(_ drawView: KMDrawView, willDrawBegin point: CGPoint) {
//        // Handle the beginning of drawing here
//        print(point)
//    }
//
//    
//    
//}
//
//extension BrushViewController: PenManagerConnectDelegate {
//    
//}
//
//extension BrushViewController: PenManagerActionDelegate {
//    func penManager(_ manager: PenManager!, didBeginDrawingWith type: TouchPenType) {
//        print(type)
//    }
//    
//    func penManager(_ manager: PenManager!, didFindNewPen pen: [AnyHashable : Any]!) {
//        print(pen)
//    }
//    
//    func penManager(_ manager: PenManager!, didFinishedDrawingWith type: TouchPenType) {
//        print(type)
//    }
//}
//
