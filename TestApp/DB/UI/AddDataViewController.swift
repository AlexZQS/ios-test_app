//// 
//  AddDataViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/9
//  
//
//

import UIKit

class AddDataViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "添加数据"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "回到数据库主页", style: UIBarButtonItem.Style.plain, target: self, action: #selector(rightClick))
        
        //有了leftBarButtonItem， backBarButtonItem失效
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItem.Style.plain, target: self, action: #selector(leftClick))

        // Do any additional setup after loading the view.
    }
    
    
    @objc func leftClick() {
        self.navigationController?.popViewController(animated: true)
        
//        self.navigationController?.popToRootViewController(animated: true)
//        if let child = self.navigationController?.children[1] {
//            self.navigationController?.popToViewController(child, animated: true)
//        }
    }
    
    
    @objc func rightClick() {
        self.navigationController?.popViewController(animated: true)
        
//        self.navigationController?.popToRootViewController(animated: true)
//        if let child = self.navigationController?.children[1] {
//            self.navigationController?.popToViewController(child, animated: true)
//        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
