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
            UIAction(title: "deleteElementsA", handler: { action in
                Task {
                    await self.testDeleteElementA()
                }
            }),
            UIAction(title: "deleteElementsB", handler: { action in
                Task {
                    await self.testDeleteElementB()
                }
            }),
            UIAction(title: "deleteElementsC", handler: { action in
                Task {
                    await self.testDeleteElementC()
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
    
    func testDeleteElementA() async {
        var arrayA = Array<StudentModel>()
        for i in 0..<5000 {
            let stududent = StudentModel()
            stududent.userId = String(i)
            stududent.name = StringUtils.generateRandomChineseString(count: 3)
            arrayA.append(stududent)
        }

        let elementsToRemove: Set = [StudentModel(id: 99), StudentModel.init(id: 799), StudentModel.init(id: 1455),StudentModel.init(id: 1001)]
        let start = DispatchTime.now()

        let resultArray = arrayA.filter { !elementsToRemove.contains($0) }
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        print("数量:\(resultArray.count)")
        let timeInterval = Double(nanoTime) / 1_000_000_000 // 转换为秒
        print("代码执行时间：\(timeInterval) 秒")
    }
    
    func testDeleteElementB() async {
        var arrayA = Array<StudentModel>()
        for i in 0..<5000 {
            let stududent = StudentModel()
            stududent.userId = String(i)
            stududent.name = StringUtils.generateRandomChineseString(count: 3)
            arrayA.append(stududent)
        }

        let elementsToRemove: Set = [StudentModel(id: 99), StudentModel.init(id: 799), StudentModel.init(id: 1455),StudentModel.init(id: 1001)]
        let start = DispatchTime.now()

        
        for (idx,item) in arrayA.enumerated() {
            if elementsToRemove.contains(item) {
                arrayA.remove(at: idx)
            }
        }
        
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        print("数量:\(arrayA.count)")
        let timeInterval = Double(nanoTime) / 1_000_000_000 // 转换为秒
        print("代码执行时间：\(timeInterval) 秒")
    }
    
    func testDeleteElementC() async {
        var arrayA = Array<StudentModel>()
        for i in 0..<5000 {
            let stududent = StudentModel()
            stududent.userId = String(i)
            stududent.name = StringUtils.generateRandomChineseString(count: 3)
            arrayA.append(stududent)
        }

        let elementsToRemove: Set = [StudentModel(id: 99), StudentModel.init(id: 799), StudentModel.init(id: 1455),StudentModel.init(id: 1001)]
        let start = DispatchTime.now()

        
        var result = Array(Set(arrayA).subtracting(elementsToRemove))
        
        result.sort { model1, model2 in
            model1.userId <= model2.userId
        }
        
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        print("数量:\(arrayA.count)")
        let timeInterval = Double(nanoTime) / 1_000_000_000 // 转换为秒
        print("代码执行时间：\(timeInterval) 秒")
    }

}
