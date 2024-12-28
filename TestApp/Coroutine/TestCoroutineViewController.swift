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
        serialQueue.async {
            self.dispatchGroup.enter()
            self.processNewMessage() {
                DispatchQueue.main.async {
                    self.updateUIForTask1 {
                        self.dispatchGroup.leave() // 标记任务完成
                    }
                }
            }
            self.dispatchGroup.wait()
        }
        
       
    }
    
    func processNewMessage() {
        // 模拟整理过程，例如合并排序
        Task.detached {
            print("开始整理消息: isMain :\(Thread.isMainThread)")
            sleep(2)
            print("整理完成: isMain :\(Thread.isMainThread)")
        }
    }
    
    func processNewMessage(completion: @escaping () async -> Void) {
        // 模拟整理过程，例如合并排序
        Task.detached {
            print("开始整理消息: isMain :\(Thread.isMainThread)")
            sleep(2)
            print("整理完成: isMain :\(Thread.isMainThread)")
            await completion()
        }
    }
    
    // 更新UI的函数1
    func updateUIForTask1(completion: @escaping () -> Void) {
        print("更新UI: 任务1完成后的UI更新 ")
        sleep(1)
        completion()
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

