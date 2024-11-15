//// 
//  ViewController.swift
//  
//  Created by ___ORGANIZATIONNAME___ on 2024/5/31
//  
//
//

import UIKit

class ViewController: UIViewController {
    
    let test = TestCoroutine()
    
    enum SomeError: Error {
        case illegalArg
        case outOffBounds
        case outOfMemory
    }
    
    
    @IBAction func leftAction(_ sender: Any) {
        
    }
    
    @IBAction func rightAction(_ sender: Any) {
        
    }
    
    @IBAction func testDB(_ sender: Any) {
        print("11111")
        let testDBViewController: UIViewController = TestDBViewController()
        self.navigationController?.pushViewController(testDBViewController, animated: true)
    }
    

    @IBAction func testGroup(_ sender: Any) {
        Task {
            await testGroupException()
        }
    }
    
    @IBAction func test(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("444444")
    }
    
    func testGroupException() async {
        do {
            let _ = try await withThrowingTaskGroup(of: Void.self) { group in
                
                print("Task Group start thread is \(Thread.current)")
                
                group.addTask {
                    try await self.groupTask1()
                }
                
                group.addTask {
                    try await self.groupTask2()
                }
                
                group.addTask {
                    try await self.groupTask3()
                }
                
                group.addTask {
                    try await self.groupTask4()
                }
                
                while(!group.isEmpty) {
                    try await group.next()
                }
            }
            print("group success")
        } catch {
            print("group error , error is \(error)")
        }
    }

    func groupTask1() async throws {
        print("groupTask1 start")
        Thread.sleep(forTimeInterval: 2)
        print("groupTask1 finish")
    }
    
    func groupTask2() async throws {
        print("groupTask2 start")
        Thread.sleep(forTimeInterval: 3)
        throw SomeError.outOfMemory
        print("groupTask2 finish")
    }
    
    func groupTask3() async throws {
        print("groupTask3 start")
        Thread.sleep(forTimeInterval: 5)
        print("groupTask3 finish")
    }
    
    func groupTask4() async throws {
        print("groupTask4 start")
        Thread.sleep(forTimeInterval: 1)
        print("groupTask4 finish")
    }

}

