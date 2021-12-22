//
//  ViewController.swift
//  曲线动画demo
//
//  Created by SXF on 2021/7/10.
//

import UIKit
let screenH = UIScreen.main.bounds.size.height
let screenW = UIScreen.main.bounds.size.width
class ViewController: UIViewController {

    
    lazy var tableView : UITableView = {
        let tab = UITableView(frame: CGRect.zero, style: .plain)
        tab.delegate = self
        tab.dataSource = self
        tab.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tab.tableFooterView = UIView()
        return tab
    }()
    
    
    var titleDict : [String : String] = [:]
    var titleSrr : [String] = [String]()
    var valueArr : [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CAShapeLayer和UIBezierPath一起才有意义"
        titleDict = [
            "CAGradientLayer的简单使用" : "CAGradientLayer_VC",
        ]
        
        for (key , value) in self.titleDict {
            titleSrr.append(key)
            valueArr.append(value)
        }
        
        
        self.tableView.frame = self.view.bounds
        self.view.addSubview(self.tableView)
    
        
        
        
        
    }
    
    
    
    
    



}


extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let classStr = self.valueArr[indexPath.row]
        //需要加上命名空间
        guard let nameSpace = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String else {
            return
        }
        guard let vcClass = NSClassFromString(nameSpace + "." + classStr) else {
            return
        }

        guard let viewControllerClassName = vcClass as? UIViewController.Type else {
            return
        }
        let vc : UIViewController = (viewControllerClassName.init() as! UIViewController)
        vc.title = self.titleSrr[indexPath.row]
        self.show(vc, sender: nil)
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleSrr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = self.titleSrr[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        
        
        return cell
    }
}

