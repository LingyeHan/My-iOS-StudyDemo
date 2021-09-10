//
//  UIHitTestViewController.swift
//  My-iOS-StudyDemo
//
//  Created by Lingye Han on 2021/3/2.
//

import UIKit

class UIHitTestViewController: UIViewController {
    private let button: HitTestButton = {
        let button = HitTestButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        button.setTitleColor(.black, for: .normal)
        button.setTitle("HitTest & PointInside", for: .normal)
//        button.sizeToFit()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        button.center = view.center
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        NSLog(#function)
    }
    
    @objc private func buttonClick() {
        print(#function)
        button.setNeedsDisplay()
    }

}

class HitTestButton: UIButton {
    
    override func draw(_ rect: CGRect) {
        print(#function)
//        CoreAnimation -> OpenGL ES(GPU) & CoreGraphics(CPU)
//        UIKit是iOS中用来管理用户图形交互的框架，但是UIKit本身构建在CoreAnimation框架之上，CoreAnimation分成了两部分OpenGL ES和Core Graphics，OpenGL ES是直接调用底层的GPU进行渲染；Core Graphics是一个基于CPU的绘制引擎；

//        所以对于当屏渲染，离屏渲染和CPU渲染的来说，当屏渲染永远是最好的选择，
//        但是考虑到GPU的浮点运算能力要比CPU强，但是由于离屏渲染需要重新开辟缓冲区以及屏幕的上下文切换，
//        所以在离屏渲染和CPU渲染的性能比较上需要根据实际情况作出选择。
//        离屏渲染的触发方式：
//        shouldRasterize（光栅化）
//        masks（遮罩）
//        shadows（阴影）
//        edge antialiasing（抗锯齿）
//        group opacity（不透明）
//        上述的一些属性设置都会产生离屏渲染的问题，大大降低GPU的渲染性能
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI() {
        backgroundColor = .red
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print(#function)
        // 扩大事件区域
        let touchRect = bounds.insetBy(dx: -100, dy: -100)
        if touchRect.contains(point) {
//            for subview in subviews.reversed() {
//                let convertedPoint = subview.convert(point, from: self)
//                if let view = subview.hitTest(convertedPoint, with: event) {
//                    return view
//                }
//            }
            return self
        }
        return nil
//        let otherView = super.hitTest(point, with: event)
//        if otherView == self {
//            return nil
//        }
//        return self
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        print(#function)
//        let extBounds = bounds.insetBy(dx: -100, dy: -100)
//        return extBounds.contains(point)
        return super.point(inside: point, with: event)
    }
}
