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
    unowned var delegate: UITableViewDelegate?
    
    let country = Country(name: "中国", capitalName: "北京")
    var city: City!
    
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
        self.city = City(name: "上海市", country: country)
        print("调用 Second Test 方法: \(self.city)")
    }
}

/**
 weak 生存期较短时（即，另一个实例可以首先被释放时），请使用弱引用
 unowned 当另一个实例具有相同的生存期或更长的生存期时，请使用无主引用
 */

//unowned所在的block的生命周期务必要比unowned修饰对象的生命周期短，即block一旦销毁了，也就不会再调用了，也就不存在修饰对象的引用问题了。
class TempNotifier {
// 相同的lifetime用unowned，无性能损耗
  var onChange: (Int) -> Void = {_ in }
  var currentTemp = 72
  init() {
    onChange = { [unowned self] temp in
      self.currentTemp = temp
    }
  }
}



class Department {
    var name: String
    var courses: [Course]
    init(name: String) {
        self.name = name
        self.courses = []
    }
}

class Course {
    var name: String
    unowned var department: Department
    unowned var nextCourse: Course?
    init(name: String, in department: Department) {
        self.name = name
        self.department = department
        self.nextCourse = nil
    }
}

//下面两个属性都应该有一个值，并且在初始化完成后，这两个属性都不应该是nil。
//在这个场景中，将一个类上的无主属性与另一个类上的隐式未包装可选属性结合起来是很有用的。
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}
class City {
    let name: String
    let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}
