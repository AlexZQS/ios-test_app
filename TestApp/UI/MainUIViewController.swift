//// 
//  MainUIViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/15
//  
//
//

import UIKit

class MainUIViewController: BaseViewController {

    @IBAction func tablePage(_ sender: Any) {
        let controller = TableViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func scrollViewPage(_ sender: Any) {
        let controller = MainScrollViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func autoLayoutScrollViewPage(_ sender: Any) {
        let controller = AutoLayoutViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func autoLayoutTableViewPage(_ sender: Any) {
        let controller = AutoLayoutTableViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func autoLayoutStackViewPage(_ sender: Any) {
        let controller = StackViewController1()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func snapKitPage(_ sender: Any) {
        let controller = SnapKitViewController1()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func snapKitPage1(_ sender: Any) {
        let controller = SnapKitViewController2()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func delegatePage(_ sender: Any) {
        let controller = DelegateViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "UI"
        // Do any additional setup after loading the view.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
        appDelegate.delegateManager.registerMessageDelegate(delegate: self)
//        appDelegate.delegateManager.setChatDelegate(chatDelegate: self)
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

extension MainUIViewController: MessageDelegate {
    
    func onMessageUpdate(list: [MessageModel]) {
        
//        for message in list {
//            if message.id == "1" {
//                message.content = "哈哈哈"
//            }
//        }
        
        for message in list {
            print("3333\(type(of: self)) message id = \(message.id) content = \(message.content)")
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            for message in list {
//                print("MainUIViewController id = \(message.id) content = \(message.content)")
//            }
//        }
        
    }
}


extension MainUIViewController: ChatDelegate {
    
    func onChatChange(list: [MessageModel]) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            for message in list {
//                print("MainUIViewController chat id = \(message.id) content = \(message.content)")
//            }
//        }
    }
    
}
