
////
//  TestIGListKitViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/12/30
//  
//
//

import UIKit
import IGListKit

struct Person2: Diffable {
    var diffIdentifier: String
    let name: String
    let content: String
    let time: String
    let sort: Int
    
    init (diffIdentifier: String, name: String, content: String, time: String,sort: Int) {
        self.diffIdentifier = diffIdentifier
        self.name = name
        self.content = content
        self.time = time
        self.sort = sort
    }
    
    
    static func == (lhs: Person2, rhs: Person2) -> Bool {
        return lhs.diffIdentifier == rhs.diffIdentifier && lhs.name == rhs.name && lhs.content == rhs.content
    }


}

class TestIGListKitViewController2: BaseViewController {
    
    lazy var adapter: ListAdapter = {
            return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 1)
        }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "TableViewCell1", bundle: nil), forCellReuseIdentifier: "userCell")
        return tableView
    }()
    
    let oldPeople = [
        Person2(diffIdentifier: "1", name: "Kevin",content: "好舒服",time: "2024/11/30",sort:1),
        Person2(diffIdentifier: "2", name: "Mike",content: "哈哈",time: "2024/10/30",sort:2),
        Person2(diffIdentifier: "3", name: "Ann",content: "今天吃什么",time: "2024/9/30",sort:3),
        Person2(diffIdentifier: "4", name: "Jane",content: "不是这个意思",time: "2024/8/30",sort:4),
        Person2(diffIdentifier: "5", name: "Philip",content: "衣服多少钱",time: "2024/7/30",sort:5),
        Person2(diffIdentifier: "6", name: "Mona",content: "11111",time: "2024/6/30",sort:6),
        Person2(diffIdentifier: "7", name: "Tami",content: "下班啊",time: "2024/5/30",sort:7),
        Person2(diffIdentifier: "8", name: "Jesse",content: "起床",time: "2024/4/30",sort:8),
        Person2(diffIdentifier: "9", name: "Jaed",content: "水电费娇娥",time: "2024/3/30",sort:9)
        ]
    
    let newPeople = [
        Person2(diffIdentifier: "2", name: "Mike",content: "哈哈1",time: "2025/10/30",sort: 1),
        Person2(diffIdentifier: "10", name: "Marne",content: "今天周几",time: "2025/10/29",sort: 2),
        Person2(diffIdentifier: "5", name: "Philip",content: "不知道啊",time: "2025/10/28",sort: 3),
        Person2(diffIdentifier: "1", name: "Kevin",content: "api地址是多少",time: "2025/10/27",sort: 4),
        Person2(diffIdentifier: "3", name: "Ryan",content: "今天收入100",time: "2025/10/26",sort: 5),
        Person2(diffIdentifier: "8", name: "Jesse",content: "来一包中华",time: "2025/10/25",sort: 6),
        Person2(diffIdentifier: "7", name: "Tami",content: "mbp 16",time: "2025/10/24",sort: 7),
        Person2(diffIdentifier: "4", name: "Jane",content: "来来来",time: "2025/10/23",sort: 8),
        Person2(diffIdentifier: "9", name: "Chen",content: "滚滚滚",time: "2025/10/22",sort: 9)
    ]
    
    lazy var people: [Person2] = {
        return self.oldPeople
    }()
    
    var usingOldPeople = true
    
//    private var diffableData: [DiffableBox<Person>] = [] // 用于差异计算

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
        // Do any additional setup after loading the view.
        self.tableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(view.snp.topMargin)
        }
        
        let popUpButton = UIButton.init(type: .system)
//      popUpButton.frame = CGRect.init(x: 100, y: 100, width: 100, height: 100)
        popUpButton.setTitle("Edit", for: .normal)
        popUpButton.showsMenuAsPrimaryAction = true
        popUpButton.menu = UIMenu(children: [
            UIAction(title: "update", handler: { action in
                self.update()
            }),
            
            UIAction(title: "move", handler: { action in
                self.move()
            }),
        ])

        let bar = UIBarButtonItem(customView: popUpButton)
        self.navigationItem.rightBarButtonItem = bar
    }
    
    func update() {
        let fromDiff = people
        var to = usingOldPeople ? newPeople : oldPeople
        
        usingOldPeople = !usingOldPeople
        to.sort { model1, model2 in
            model1.sort <= model2.sort
        }
//        var toDiff = to.map { ListDiffableBox(value: $0, identifier: String($0.pk)) }
        people = to
        
        let result = DiffUtility.diff(originalItems: fromDiff, newItems: to)
        
        tableView.beginUpdates()
//        tableView.reloadRows(at: result.updates, with: .none)
        tableView.deleteRows(at: result.deletions, with: .automatic)
        tableView.insertRows(at: result.inserts, with: .automatic)
        result.moves.forEach { tableView.moveRow(at: $0.from, to: $0.to) }
        tableView.endUpdates()
    }
    
    func move() {
        let from = people
        
        print("\(#file) 开始移动了 ")
        var newPeople = [
            Person2(diffIdentifier: "2", name: "Mike",content: "哈哈1",time: "2025/10/30",sort: 3),
            Person2(diffIdentifier: "10", name: "Marne",content: "今天周几",time: "2025/10/29",sort: 4),
            Person2(diffIdentifier: "5", name: "Philip",content: "不知道啊",time: "2025/10/28",sort: 1),
            Person2(diffIdentifier: "1", name: "Kevin",content: "api地址是多少",time: "2025/10/27",sort: 2),
            Person2(diffIdentifier: "3", name: "Ryan",content: "今天收入100",time: "2025/10/26",sort: 5),
            Person2(diffIdentifier: "8", name: "Jesse",content: "来一包中华",time: "2025/10/25",sort: 6),
            Person2(diffIdentifier: "7", name: "Tami",content: "mbp 16",time: "2025/10/24",sort: 7),
            Person2(diffIdentifier: "4", name: "Jane",content: "来来来",time: "2025/10/23",sort: 8),
            Person2(diffIdentifier: "9", name: "Chen",content: "滚滚滚",time: "2025/10/22",sort: 9)
        ]
        newPeople.sort { model1, model2 in
            model1.sort <= model2.sort
        }
        people = newPeople
        let result = DiffUtility.diff(originalItems: from, newItems: newPeople)

        tableView.beginUpdates()
        tableView.deleteRows(at: result.deletions, with: .fade)
        tableView.insertRows(at: result.inserts, with: .fade)
        result.moves.forEach { tableView.moveRow(at: $0.from, to: $0.to) }
        tableView.endUpdates()
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

extension TestIGListKitViewController2: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? TableViewCell1
        
        if cell == nil {
            cell = TableViewCell1.init(style: .default, reuseIdentifier: "userCell")
        }
        let peopleItem = people[indexPath.row]
        
        print("\(#file) set model 开始了，peopleItem:\(peopleItem.name) indexPath.row:\(indexPath.row)")
        cell?.mBodyView.text = peopleItem.content
        cell?.mTitleView.text = peopleItem.name
        cell?.mTimeView.text = peopleItem.time
        return cell!
    }
    
}
