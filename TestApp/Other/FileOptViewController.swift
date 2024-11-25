////
//  FileOperationViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/11/15
//
//
//

import UIKit
import UniformTypeIdentifiers
import CryptoKit
import Alamofire

class FileOptViewController: BaseViewController {
    
    lazy var btnSelectFile: UIButton = {
        if #available(iOS 15.0, *) {
            var button = UIButton(configuration: .filled(),primaryAction: UIAction(title: "选择文件",handler: { _ in
                let supportedTypes: [UTType] = [UTType.pdf, UTType.image, UTType.text]
                let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes)
                documentPicker.delegate = self
                documentPicker.allowsMultipleSelection = false // 是否允许多选
                self.present(documentPicker, animated: true, completion: nil)
            }))
            return button
        } else {
            // Fallback on earlier versions
            var button1 = UIButton(type: .roundedRect)
            button1.backgroundColor = UIColor.systemBlue
            return button1
        }
    }()
    
    
    lazy var btnDownloadFile: UIButton = {
        if #available(iOS 15.0, *) {
            var button = UIButton(configuration: .filled(),primaryAction: UIAction(title: "下载文件",handler: { _ in
                Task {
                    await self.downloadFile()
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
    
    lazy var lbFileInfo: UILabel = {
        var lable = UILabel(frame: .zero)
        return lable
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "文件操作"
        
        view.addSubview(btnSelectFile)
        view.addSubview(btnDownloadFile)

        btnSelectFile.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp_topMargin).offset(30)
            make.left.equalToSuperview().offset(30)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        btnDownloadFile.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp_topMargin).offset(30)
            make.right.equalToSuperview().offset(-30)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        
        view.addSubview(lbFileInfo)
        lbFileInfo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(btnSelectFile.snp.bottom).offset(30)
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
    
    func downloadFile() async {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 15
        
//        configuration.httpAdditionalHeaders = ["User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"]
        
        let session = URLSession(configuration: configuration)
        
        let tsPath = "https://test-streams.mux.dev/x36xhzz/url_0/url_462/193039199_mp4_h264_aac_hd_7.ts"
        if let url = URL.init(string: "https://test-streams.mux.dev/x36xhzz/url_0/url_462/193039199_mp4_h264_aac_hd_7.ts") {
            var destinationPath = ""
            if let cachesDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                destinationPath = "\(cachesDirectory.path)/cache/"
            }
            let destination: DownloadRequest.Destination = { _, _ in
                    let fileURL = URL(fileURLWithPath: destinationPath)
                    return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
                }
                
//                AF.download(tsPath, to: destination).response { response in
//                    if let filePath = response.fileURL {
//                        print("************ success url = \(url.absoluteString)")
//                    } else if let error = response.error {
//                        print("************ failed error = \(error)")
//                    }
//                }
            
//            AF.request(tsPath).responseData { response in
//                switch response.result {
//                case .success(let m3u8Content):
//                    YHDebugLog("************ success url = \(url.absoluteString)")
//                case .failure(let error):
//                    YHDebugLog("************ failed error = \(error)")
//                }
//            }
            
            var request = URLRequest(url: url)
//            request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
           
            let session1 = URLSession.shared
//            session.downloadTask(withResumeData: <#T##Data#>)
//            session.downloadTask(withResumeData: data) { url, request, error in
//                if let mError = error {
//                    print("************ failed error = \(mError)")
//                    return
//                }
//                print("************ success url = \(url?.absoluteString ?? "")")
//            }.resume()
            session.downloadTask(with: url) { url, response, error in
                if let mError = error {
                    print("************ failed error = \(mError)")
                    return
                }
                print("************ success url = \(url?.absoluteString ?? "")")
            }.resume()
        
            
//            session.dataTask(with: request) {  data, response, error in
//                if let mData = data {
//                    YHDebugLog("************ success data = \(String(data: mData, encoding: .utf8))")
//                    return
//                }
//                YHDebugLog("************ failed error = \(error)")
//            }.resume()
        }
    }
    
    func fileType(fileURL: URL) -> String? {
        let fileHandle: FileHandle?
        do {
            fileHandle = try FileHandle(forReadingFrom: fileURL)
        } catch {
            print("无法读取文件: \(error)")
            return nil
        }
        
        // 读取前8个字节
        let magicBytes = fileHandle?.readData(ofLength: 8)
        fileHandle?.closeFile()
        
        guard let data = magicBytes else {
            print("无法读取文件头")
            return nil
        }
        
        // 转换为十六进制字符串
        let hexString = data.map { String(format: "%02X", $0) }.joined()
        
        // 匹配文件类型
        switch hexString {
        case let hex where hex.hasPrefix("89504E47"):
            return "PNG Image"
        case let hex where hex.hasPrefix("FFD8FF"):
            return "JPEG Image"
        case let hex where hex.hasPrefix("47494638"):
            return "GIF Image"
        case let hex where hex.hasPrefix("424D"):
            return "BMP Image"
        case let hex where hex.hasPrefix("49492A00") || hex.hasPrefix("4D4D002A"):
            return "TIFF Image"
        case let hex where hex.hasPrefix("25504446"):
            return "PDF Document"
        case let hex where hex.hasPrefix("504B0304"):
            return "ZIP Archive"
        case let hex where hex.hasPrefix("52617221"):
            return "RAR Archive"
        case let hex where hex.hasPrefix("377ABC"):
            return "7Z Archive"
        case let hex where hex.hasPrefix("0000001866747970"):
            return "MP4 Video"
        case let hex where hex.hasPrefix("52494646"):
            return "AVI Video or WAV Audio"
        case let hex where hex.hasPrefix("494433") || hex.hasPrefix("FFFB"):
            return "MP3 Audio"
        case let hex where hex.hasPrefix("664C6143"):
            return "FLAC Audio"
        case let hex where hex.hasPrefix("4D5A"):
            return "Windows EXE Executable"
        case let hex where hex.hasPrefix("7F454C46"):
            return "ELF Executable"
        default:
            return "Unknown Type"
        }
    }
    
    func fileMD5Hex(for filePath: URL) -> String? {
        guard let fileHandle = try? FileHandle(forReadingFrom: filePath) else {
            print("无法打开文件：\(filePath)")
            return nil
        }
        defer { fileHandle.closeFile() }
        
        // 初始化 MD5 哈希计算器
        var md5 = Insecure.MD5()
        
        // 每次读取文件的一部分，更新哈希值
        let bufferSize = 1024 * 1024 // 每次读取 1MB
        while autoreleasepool(invoking: {
            let data = fileHandle.readData(ofLength: bufferSize)
            if !data.isEmpty {
                md5.update(data: data)
                return true
            }
            return false
        }) { }
        
        // 获取最终的 MD5 哈希值
        let digest = md5.finalize()
        
        // 转换为 HEX 格式
        return digest.map { String(format: "%02x", $0) }.joined()
    }
    
}


extension FileOptViewController: UIDocumentPickerDelegate {
    // 用户选择了文件
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else { return }
        print("Selected file URL: \(selectedFileURL)")
        
        // 检查文件是否可以被访问
        let isAccessing = selectedFileURL.startAccessingSecurityScopedResource()
        if isAccessing {
            // 在这里读取文件内容或处理文件
            do {
                let fileData = try Data(contentsOf: selectedFileURL)
                let fileId = fileMD5Hex(for: selectedFileURL) ?? ""
                let fileType = fileType(fileURL: selectedFileURL) ?? ""
                let fileExtension = selectedFileURL.pathExtension
                print("File size: \(fileData.count) bytes \n")
                print("File ID: \(fileId) \n")
                print("File Type: \(fileType) \n")
                print("File Extension: \(fileExtension) \n")
                
                
                
            } catch {
                print("Failed to read file: \(error)")
            }
            selectedFileURL.stopAccessingSecurityScopedResource()
        }
    }
}
