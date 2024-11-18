//// 
//  MainViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/8
//  
//
//

import UIKit

class MainViewController: BaseViewController {
    
    @IBAction func testCouroutine(_ sender: Any) {
        let controller = TestCoroutineViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func dbPage(_ sender: Any) {
        let controller = TestDBViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func UITestPage(_ sender: Any) {
        let controller = MainUIViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func animationPage(_ sender: Any) {
        let controller = AnimationMainViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func flutterPage(_ sender: Any) {
        let controller = FlutterMainViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func otherPage(_ sender: Any) {
        let vc = OtherMainViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func webPage(_ sender: Any) {
        let vc = UrlViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
//        appDelegate.delegateManager.registerMessageDelegate(delegate: self)
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

extension MainViewController: MessageDelegate {
    
    func onMessageUpdate(list: [MessageModel]) {
        
        var newMessages: [MessageModel] = []
        newMessages.append(contentsOf: list)
        
        for message in list {
            print("111\(type(of: self)) message id = \(message.id) content = \(message.content)")
        }
        
        
        
        for var message in newMessages {
            if message.id == "1" {
                message.content = "\(type(of: self)) 修改了数据 哈哈哈"
            }
        }
        
        for message in newMessages {
            print("2222\(type(of: self)) id = \(message.id) content = \(message.content)")
        }
        
        
    }
    
}
