//// 
//  TestCoroutineViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/12
//  
//
//

import UIKit

class TestCoroutineViewController: BaseViewController {

    var enableData = ActorData()
    
    private let serialQueue = DispatchQueue(label: "com.example.serialQueue")
    private let dispatchGroup = DispatchGroup()
    
    @IBAction func testMainActor(_ sender: Any) {
        for i in 0..<10{
            test1()
        }
    }
    @IBAction func testActor(_ sender: Any) {
        do {
            Task {
                for c in 1...100 {
    //                    data.loadCount = i
                        let cache = await enableData.getChatMessageCache(chatId:1)
                        cache.loadCount = c
                        print("c = \(c)")
                        try await enableData.test1()
                }
                
                print("===================================================")
                
                for i in 1...100 {
                    Task {
    //                    data.loadCount = i
                        let cache = await enableData.getChatMessageCache(chatId:1)
                        cache.loadCount = cache.loadCount + 1
                        try await enableData.test1()
                        
                    }
                }
            }
            
           
        } catch {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    let queue = TaskQueue()
    
    func test() {
        Task.detached {
            print("主线程:\(Thread.current.isMainThread)添加任务开始-1")
            await self.queue.addTask {
                print("主线程:\(Thread.current.isMainThread)添加任务开始0")
//                await self.test2()
                await self.testSub()
                await MainActor.run {
                    print("主线程:\(Thread.current.isMainThread)耗时任务开始3")
                    Thread.sleep(forTimeInterval: 0.1)
                    print("主线程:\(Thread.current.isMainThread)耗时任务开始4")
                }
            }
        }
    }
    
    func testSub() async {
        print("主线程:\(Thread.current.isMainThread)耗时任务开始1")
        print("主线程:\(Thread.current.isMainThread)耗时任务结束2")
    }
    
    func test1()  {
        dispatchGroup.enter()
        serialQueue.async(group: dispatchGroup) {
            self.dispatchGroup.wait()
            // 模拟IO操作，比如从网络获取数据
            print("任务1开始 - IO 操作")
            sleep(2)  // 模拟IO操作延时
            print("任务1完成 - IO 操作")
            
            // IO操作完成后，更新UI
            DispatchQueue.main.async {
                self.updateUIForTask1()
                self.dispatchGroup.leave()
            }
        }
    }
    
    // 更新UI的函数1
    func updateUIForTask1() {
        print("更新UI: 任务1完成后的UI更新")
        // 在这里更新你的UI组件，例如Label、Button等
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

