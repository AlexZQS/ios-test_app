//// 
//  FileOperationViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/11/15
//  
//
//

import UIKit
import TZImagePickerController

class ImageOptViewController: BaseViewController {

    lazy var btnSelectImg: UIButton = {
        if #available(iOS 15.0, *) {
            var button = UIButton(configuration: .filled(),primaryAction: UIAction(title: "选择图片",handler: { _ in
                if let vc = TZImagePickerController.init(maxImagesCount: 9, delegate: self) {
                    self.present(vc, animated: true)
                }
            }))
            return button
        } else {
            // Fallback on earlier versions
            var button1 = UIButton(type: .roundedRect)
            button1.backgroundColor = UIColor.systemBlue
            return button1
        }
    }()
    
    lazy var lbImageInfo: UILabel = {
        var lable = UILabel(frame: .zero)
        return lable
    }()
    
    
    lazy var ivImage: UIImageView = {
        var image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "文件操作"
        
        view.addSubview(btnSelectImg)
        btnSelectImg.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp_topMargin).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        view.addSubview(ivImage)
        ivImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(btnSelectImg.snp.bottom).offset(30)
            make.size.equalTo(200)
        }
        
        view.addSubview(lbImageInfo)
        lbImageInfo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(ivImage.snp.bottom).offset(30)
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

extension ImageOptViewController: TZImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingVideo coverImage: UIImage!, sourceAssets asset: PHAsset!) {
    }
    
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool, infos: [[AnyHashable : Any]]!) {
        ivImage.image = photos.first
        
        
    }
}
