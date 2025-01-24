//// 
//  TestDBViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/7
//  
//
//

import UIKit
import WCDBSwift

class TestDBViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var models = Array<StudentModel>()
    
    var dataBase:Database? = nil
    
    var queue: UUQueue<Database>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "数据库测试"
        self.initDB()
        
        do {
            try StudentModelDao.createTable(userDB: dataBase, tableName: StudentModelDao.table_name)
            loadData()
        } catch {
            print(error)
        }
        
//        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "添加数据", style: UIBarButtonItem.Style.plain, target: self, action: #selector(rightClick))
        
//        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "添加数据", style: UIBarButtonItem.Style.plain, target: self, action: #selector(rightClick)),UIBarButtonItem(title: "添加数据", style: UIBarButtonItem.Style.plain, target: self, action: #selector(rightClick))]
        let popUpButton = UIButton.init(type: .system)
        popUpButton.setTitle("Edit", for: .normal)
        popUpButton.showsMenuAsPrimaryAction = true
        popUpButton.menu = UIMenu(children: [
            UIAction(title: "清除数据", handler: { action in
                self.clearData()
            }),
            UIAction(title: "添加数据", handler: { action in
                self.addData()
            }),
            UIAction(title: "添加数据(冲突)", handler: { action in
                self.addConflictData()
            }),
            UIAction(title: "查询columns", handler: { action in
                self.queryIds()
            }),
            UIAction(title: "添加一条数据", handler: { action in
                Task {
                    await self.addOneData()
                }
            }),
            UIAction(title: "添加1000 条数据", handler: { action in
                Task {
                    await self.addLargeDatas(isTransaction: false)
                }
            }),
            UIAction(title: "添加1000 条数据(事务)", handler: { action in
                Task {
                    await self.addLargeDatas(isTransaction: true)
                }
            }),
            UIAction(title: "退出", handler: {action in
                self.navigationController?.popViewController(animated: true)
            })
        ])

        let bar = UIBarButtonItem(customView: popUpButton)
        self.navigationItem.rightBarButtonItem = bar
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // Do any additional setup after loading the view.
        
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
//        appDelegate.delegateManager.registerMessageDelegate(delegate: self)
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func rightClick(button: UIBarButtonItem) {
        
        let addDataController = AddDataViewController()
        self.navigationController?.pushViewController(addDataController, animated: true)
    }
    
    func loadData() {
        Task {
            do {
                let users = try await StudentModelDao.queryUsers(userDB: dataBase)
                DispatchQueue.main.async {
                    self.models.append(contentsOf: users)
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
        
    }
    
    func initDB() {
        self.queue = UUQueue(lable: "com.alex.study.userQueue", initT: {
            let db = DBUtils.initDB()
            self.dataBase = db
            return db
        })
    }
    
    func clearData() {
        Task {
            do {
                try await StudentModelDao.clear(userDB: dataBase)
                let users = try await StudentModelDao.queryUsers(userDB: dataBase)
                
                DispatchQueue.main.async {
                    self.models.removeAll()
                    self.models.append(contentsOf: users)
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
    
    
    func addOneData() async {
        let stududent = StudentModel()
        stududent.userId = "910"
        stududent.name = "哈哈哈"
        
        do {
            try await StudentModelDao.insertUser(userDB: dataBase, student: stududent)
            print("添加数据的id 111：lastInsertedRowID = \(stududent.lastInsertedRowID) id = \(stududent.id)")
            let newUser = try await StudentModelDao.queryUser(userDB: dataBase, userId: stududent.userId)
            print("添加数据的id 222：userId = \(newUser?.userId) lastInsertedRowID = \(newUser?.lastInsertedRowID) id = \(newUser?.id)")
        } catch {
            print("报错了 \(error)")
        }
    }
    
    func addData() {
        Task {
            var datas = Array<StudentModel>()
            let stududent = StudentModel()
            stududent.userId = "1"
            stududent.name = "李四"
            datas.append(stududent)
            
            let stududent1 = StudentModel()
            stududent1.userId = "2"
            stududent1.name = "王五"
            datas.append(stududent1)
            
            let stududent2 = StudentModel()
            stududent2.userId = "3"
            stududent2.name = "老李"
            datas.append(stududent2)
            
            let stududent3 = StudentModel()
            stududent3.userId = "4"
            stududent3.name = "李飞1111"
            datas.append(stududent3)
            
            do {
                try await StudentModelDao.insertUser(userDB: dataBase, users: datas)
                let users = try await StudentModelDao.queryUsers(userDB: dataBase)
                
                DispatchQueue.main.async {
                    self.models.removeAll()
                    self.models.append(contentsOf: users)
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
            
            
            
        }
    }
    
    func addConflictData() {
        Task {
            var datas = Array<StudentModel>()
            let stududent = StudentModel()
            stududent.userId = "1"
            stududent.name = "李四"
            datas.append(stududent)
            
            let stududent1 = StudentModel()
            stududent1.userId = "2"
            stududent1.name = "王五"
            datas.append(stududent1)
            
            let stududent2 = StudentModel()
            stududent2.userId = "3"
            stududent2.name = "老李"
            datas.append(stududent2)
            
            let stududent3 = StudentModel()
            stududent3.userId = "4"
            stududent3.name = "李飞1111更新"
            datas.append(stududent3)
            
            let stududent4 = StudentModel()
            stududent4.userId = "5"
            stududent4.name = "新增的数据111"
            datas.append(stududent4)
            
            let stududent5 = StudentModel()
            stududent5.userId = "6"
            stududent5.name = "新增的数据222"
            datas.append(stududent5)
            
            
            let stududent6 = StudentModel()
            stududent6.userId = "8"
            stududent6.name = "新增的数据888"
            datas.append(stududent6)
            
            
            
            do {
                let results = try await StudentModelDao.insertUsers3(userDB: dataBase, users: datas)
//                try await StudentModelDao.insertUsers2(queue: self.queue, users: datas)
//                for data in results {
//                    print("userId = \(data.userId) name =\(data.name) lastInsertedRowID = \(data.lastInsertedRowID) id = \(data.id)")
//                }
                let users = try await StudentModelDao.queryUsers(userDB: dataBase)
                
                DispatchQueue.main.async {
                    self.models.removeAll()
                    self.models.append(contentsOf: users)
                    self.tableView.reloadData()
                }
            } catch {
                if let dbError = error as? WCDBError, dbError.extendedCode == WCDBError.ExtendCode.ConstraintPrimaryKey {
                    print("检测到冲突了\(error) ")
                } else {
                    print("检测到错误了\(error) ")
                }
            }
        }
    }
    
    func addLargeDatas(isTransaction:Bool) async {
        var datas = Array<StudentModel>()
        let stududent = StudentModel()
        stududent.userId = "1"
        stududent.name = "李四"
        datas.append(stududent)
        
        let stududent1 = StudentModel()
        stududent1.userId = "2"
        stududent1.name = "王五"
        datas.append(stududent1)
        
        let stududent2 = StudentModel()
        stududent2.userId = "3"
        stududent2.name = "老李"
        datas.append(stududent2)
        
        let stududent3 = StudentModel()
        stududent3.userId = "4"
        stududent3.name = "李飞1111"
        datas.append(stududent3)
        
        for i in 0..<5000 {
            let stududent = StudentModel()
            stududent.userId = String(i)
            stududent.name = StringUtils.generateRandomChineseString(count: 3)
            datas.append(stududent)
        }
        do {
            let startTime = CFAbsoluteTimeGetCurrent()
            if isTransaction {
                try await StudentModelDao.insertUsers4(userDB: dataBase, users: datas)
            } else {
                let uids = datas.map { model in
                    model.userId
                }
                let existDatas = try await StudentModelDao.queryUsers(userDB: dataBase, userIds: uids)
                let insertDatas = datas.filter { model in
                    !existDatas.contains(model)
                }
                try await StudentModelDao.insertUsers3(userDB: dataBase, users: insertDatas)
            }
            let endTime = CFAbsoluteTimeGetCurrent()
            print("\(#function) 是否用了事务: \(isTransaction) 耗时: \(endTime - startTime) 秒")
            
            let users = try await StudentModelDao.queryUsers(userDB: dataBase)
            
            DispatchQueue.main.async {
                self.models.removeAll()
                self.models.append(contentsOf: users)
                self.tableView.reloadData()
            }
        } catch {
            if let dbError = error as? WCDBError, dbError.extendedCode == WCDBError.ExtendCode.ConstraintPrimaryKey {
                print("检测到冲突了\(error) ")
            } else {
                print("检测到错误了\(error) ")
            }
        }
            
    }
    
    func queryIds() {
        Task {
            let ids = try await StudentModelDao.queryUserIds(userDB: dataBase)
            UIAlertController.showAlert(message: "用户ids是 \n \(ids)")
        }
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

extension TestDBViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "userCell")
        
        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: "userCell")
        }
        cell?.detailTextLabel?.text = self.models[indexPath.row].name ?? ""
        cell?.textLabel?.text = self.models[indexPath.row].userId
        return cell!
    }
    
    
    
    
}

extension TestDBViewController: UITableViewDelegate {
    
}

//extension TestDBViewController: MessageDelegate {
//    
//    func onMessageUpdate(list: [MessageModel]) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            for message in list {
//                print("TestDBViewController chat id = \(message.id) content = \(message.content)")
//            }
//        }
//    }
//    
//}

