//
//  FirstViewController.swift
//  My-iOS-StudyDemo
//
//  Created by Lingye Han on 2021/3/1.
//

import UIKit

class FirstViewController: UIViewController {
    private let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("跳转到 SecondViewController", for: .normal)
        button.sizeToFit()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        button.center = view.center
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
    }
    
    @objc private func buttonClick() {
        let secondViewController = SecondViewController()
        navigationController?.pushViewController(secondViewController, animated: true)
    }
}
