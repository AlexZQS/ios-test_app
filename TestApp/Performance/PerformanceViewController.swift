//// 
//  PerformanceViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2025/1/11
//  
//
//

import UIKit

class PerformanceViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "性能测试"
        let popUpButton = UIButton.init(type: .system)
        popUpButton.setTitle("Edit", for: .normal)
        popUpButton.showsMenuAsPrimaryAction = true
        popUpButton.menu = UIMenu(children: [
            UIAction(title: "firstIndex", handler: { action in
                Task {
                    await self.testFirstIndex()
                }
            }),
        ])

        let bar = UIBarButtonItem(customView: popUpButton)
        self.navigationItem.rightBarButtonItem = bar
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func testFirstIndex() async {
        var datas = Array<StudentModel>()
        for i in 0..<5000 {
            let stududent = StudentModel()
            stududent.userId = String(i)
            stududent.name = StringUtils.generateRandomChineseString(count: 3)
            datas.append(stududent)
        }
        
        
        let startTime = CFAbsoluteTimeGetCurrent()
        let stududent = StudentModel()
        stududent.userId = String(4000)
        let index = datas.firstIndex(of: stududent)
        let endTime = CFAbsoluteTimeGetCurrent()
        print("\(#function) index: \(index) firstIndex 耗时: \(endTime - startTime) 秒")

        let startTime1 = CFAbsoluteTimeGetCurrent()

        for item in datas {
            if item.userId == String(4000) {
                
                continue
            }
        }
        let endTime1 = CFAbsoluteTimeGetCurrent()

        print("\(#function) index: \(index) for 查找 耗时: \(endTime1 - startTime1) 秒")

        
    }

}
