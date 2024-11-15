//// 
//  UIScrollViewController1.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/15
//  
//
//

import UIKit

class UIScrollViewController1: BaseViewController {
    
    var uiImage: UIImageView?

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "ScrollView"
        
        var img = UIImage.init(named: "img.jepg")
        self.uiImage = UIImageView(image: img)
        self.scrollView.addSubview(self.uiImage!)
        self.scrollView.delegate = self
        
        // contentSize: 内容的大小 CGSize(有宽有高)，决定了滚动的范围
        self.scrollView.contentSize = CGSize(width: 1200, height: 800)
        
        // contentOffset: 内容的偏离，CGFloat
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

extension UIScrollViewController1: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
}
