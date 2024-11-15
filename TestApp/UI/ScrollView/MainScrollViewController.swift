//// 
//  MainScrollViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/15
//  
//
//

import UIKit

class MainScrollViewController: BaseViewController {
    
    @IBAction func scrollViewPage2(_ sender: Any) {
        let controller = UIScrollViewController2()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func scrollViewPage1(_ sender: Any) {
        let controller = UIScrollViewController1()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
            
        // Do any additional setup after loading the view.
        self.navigationItem.title = "ScrollView"
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
        appDelegate.delegateManager.registerMessageDelegate(delegate: self)
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

extension MainScrollViewController: MessageDelegate {
    
    func onMessageUpdate(list: [MessageModel]) {
        
//        for message in list {
//            if message.id == "1" {
//                message.content = "哈哈哈"
//            }
//        }
        for message in list {
            print("\(type(of: self)) message id = \(message.id) content = \(message.content)")
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            for message in list {
//                print("MainUIViewController id = \(message.id) content = \(message.content)")
//            }
//        }
        
    }
}

