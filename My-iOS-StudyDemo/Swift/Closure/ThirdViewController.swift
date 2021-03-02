//
//  ThirdViewController.swift
//  My-iOS-StudyDemo
//
//  Created by Lingye Han on 2021/3/1.
//

import UIKit

class ThirdViewController: UIViewController {
    private let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("点击按钮", for: .normal)
        button.sizeToFit()
        return button
    }()
    
    var closure: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        button.center = view.center
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        
        // 方式一：自定义通知队列：可以始终在主线程中更新UI
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Test"), object: nil, queue: OperationQueue.main) { (notification) in
            self.button.setTitle("通知", for: .normal)
        }
        
        // 方式二：需要在方法中加上主线程
        NotificationCenter.default.addObserver(self, selector: #selector(notice), name: NSNotification.Name("Test"), object: nil)
    }

    @objc func notice() {
        print("KVO或Notification不管添加通知在主线程还是子线程, 接收通知的方法所在的线程是由发送通知的线程决定的")
        print("当前线程是否主线程: %@", Thread.current.isMainThread)
        DispatchQueue.main.async {
            self.button.setTitle("通知", for: .normal)
        }
    }
    
    deinit {
        print("ThirdViewController - 被释放了")
        NotificationCenter.default.removeObserver(NSNotification.Name("Test"))
    }
    
    @objc private func buttonClick() {
        // 模拟网络请求
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            self.closure?()
            NotificationCenter.default.post(name: NSNotification.Name("Test"), object: nil)
        }
    }
}
