//
//  KVCViewController.swift
//  My-iOS-StudyDemo
//
//  Created by Lingye Han on 2021/3/26.
//

import UIKit

class KVCObject: NSObject {
    @objc var name: String = "hello"
//    @objc var name: String {
//        set {
//            _name = newValue
//        }
//        get {
//            return _name
//        }
//    }
    
    override init() {
        super.init()
        
    }
    
//    @objc func setName(name: String) {
//        self._name = name
//    }
//
//    @objc func getName() -> String {
//        return self._name
//    }
}

class KVCViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let kvcObj = KVCObject()
        kvcObj.addObserver(self, forKeyPath: "name", options: .new, context: nil)
        kvcObj.setValue("test", forKey: "name")
//        kvcObj.setName(name: "test")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("KVO: \(keyPath)  \(object)  \(change)")
    }

}
