//// 
//  TestUIViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/9
//  
//
//

import UIKit

class TableViewController: BaseViewController {
    
    
    
    @IBAction func uiTableViewPage(_ sender: Any) {
        let controller = TestUITableViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @IBAction func uiTableViewPage1(_ sender: Any) {
        let controller = TestUITableDelegateViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func uiTableViewPage2(_ sender: Any) {
        let controller = TestUiTableIndexViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func uiTableViewPage3(_ sender: Any) {
        let controller = UITableCustomCellViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func uiTableViewPage4(_ sender: Any) {
        let controller = UIDiffTableViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TableView"
        // Do any additional setup after loading the view.
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
