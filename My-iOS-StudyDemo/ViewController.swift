//
//  ViewController.swift
//  My-iOS-StudyDemo
//
//  Created by Lingye Han on 2021/3/1.
//

import UIKit

// https://www.jb51.net/list/list_244_3.htm

class ViewController: UITableViewController {
    
    let items = ["Closure", "UI"]
    let vcs = [FirstViewController.self, UITestViewController.self]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


        let vc = vcs[indexPath.row].init()
        navigationController?.pushViewController(vc, animated: true)
    }
}

class DemoViewController: UIViewController {
    private let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("测试", for: .normal)
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

    }
}
