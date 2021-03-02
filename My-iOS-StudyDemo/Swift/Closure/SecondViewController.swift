//
//  SecondViewController.swift
//  My-iOS-StudyDemo
//
//  Created by Lingye Han on 2021/3/1.
//

import UIKit

class SecondViewController: UIViewController {
    private let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("跳转到 ThirdViewController", for: .normal)
        button.sizeToFit()
        return button
    }()
    
    private let thirdViewController = ThirdViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        button.center = view.center
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
    }
    
    deinit {
        print("SecondViewController - 被释放了")
    }
    
    @objc private func buttonClick() {
        //let thirdViewController = ThirdViewController()
        thirdViewController.closure = { [weak self] in
//            guard let `self` = self else { return }
            self?.test()
        }
        navigationController?.pushViewController(thirdViewController, animated: true)
    }
    
    private func test() {
        print("调用 Second Test 方法")
    }
}
