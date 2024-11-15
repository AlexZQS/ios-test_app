//// 
//  UUTaskQueue.swift
//  UUTalk-iOS
//  Created by ___ORGANIZATIONNAME___ on 2024/9/23
//  
//
//

import Foundation

actor TaskQueue {
    private var tasks: [() async -> Void] = []
    private var isProcessing = false

    // 添加任务到队列
    func addTask(_ task: @escaping () async -> Void) async {
        tasks.append(task)
        await processNextTask()
    }

    // 处理下一个任务
    private func processNextTask() async {
        guard !isProcessing, !tasks.isEmpty else { return }

        isProcessing = true
        let task = tasks.removeFirst()

        await task()

        isProcessing = false
        await processNextTask() // 继续处理队列中的下一个任务
    }
}
