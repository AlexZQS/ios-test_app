//// 
//  DelegateViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/8/31
//  
//
//

import UIKit

class DelegateViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Delegate 测试"
        self.view.backgroundColor = UIColor.white
        let button = UIButton(type: .system)
        
        button.setTitle("消息来了", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        self.view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        button.addTarget(self, action: #selector(messageDelegateAction), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    
    @objc private func messageDelegateAction() {
        
        var messages = [MessageModel]()
        
        let message1 = MessageModel()
        message1.id = "1"
        message1.content = "aaa"
        messages.append(message1)
        
        let message2 = MessageModel()
        message2.id = "2"
        message2.content = "sss"
        messages.append(message2)

        
        let message3 = MessageModel()
        message3.id = "3"
        message3.content = "vvvv"
        messages.append(message3)

        
        let message4 = MessageModel()
        message4.id = "4"
        message4.content = "gggg"
        messages.append(message4)

        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return  }
        let mMessages = NSMutableArray(array: messages).mutableCopy()
        delegate.delegateManager.onMessageUpdagte(list: mMessages as! [MessageModel])
        delegate.delegateManager.chatDelegate?.onChatChange(list: messages)
//        for var message in messages {
//            if message.id == "2" {
//                message.content = "三等奖"
//            }
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
