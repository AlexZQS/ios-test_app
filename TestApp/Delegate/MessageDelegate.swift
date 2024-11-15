//// 
//  MessageDelegate.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/8/31
//  
//
//

import Foundation

public protocol MessageDelegate {
    func onMessageUpdate(list: [MessageModel])
}
