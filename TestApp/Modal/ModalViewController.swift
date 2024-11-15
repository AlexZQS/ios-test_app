//// 
//  ModalViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/9
//  
//
//

import UIKit

class ModalViewController: UIViewController {

    @IBAction func jumpVc1(_ sender: Any) {
        //构造想跳转的界面
        let destVc = UIStoryboard.init(name: "Modal", bundle: nil).instantiateViewController(identifier: "dest")
//        let destVc = DesModalViewController()
        self.present(destVc, animated: true)
    }
    
    @IBAction func jumpVc3(_ sender: Any) {
        // 让连线产生作用
        self.performSegue(withIdentifier: "aaa", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
