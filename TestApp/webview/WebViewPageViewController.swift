//// 
//  WebViewPageViewController.swift
//  movie_h5
//  Created by ___ORGANIZATIONNAME___ on 2024/11/18
//  
//
//

import UIKit
import WebKit

class WebViewPageViewController: BaseViewController,WKNavigationDelegate,WKScriptMessageHandler {

    var webView: WKWebView!
    var loading: UIActivityIndicatorView!
    
    var host: String = ""
    
    init(host: String) {
        self.host = host
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
//        let userContentController = WKUserContentController()
//        userContentController.add(self, name: "myBridge")
        
        let configure = WKWebViewConfiguration()
//        configure.userContentController = userContentController
        webView = WKWebView.init(frame: .zero, configuration: configure)
        webView.navigationDelegate = self
        view.addSubview(webView)
        
//        loading = UIActivityIndicatorView(style: .large)
//        loading.center = view.center
//        loading.hidesWhenStopped = true
//        view.addSubview(loading)
        
        // 添加约束，以确保WKWebView填充整个视图
        webView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp_topMargin)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.pinchGestureRecognizer?.isEnabled = false

        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.alwaysBounceVertical = false
        webView.scrollView.alwaysBounceHorizontal = false
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
//        let disableScrollScript = """
//        document.body.style.overflow = 'hidden';
//        document.documentElement.style.overflow = 'hidden';
//        """
//        webView.evaluateJavaScript(disableScrollScript, completionHandler: nil)
//        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        if #available(iOS 11.0, *) {
            webView.scrollView.contentInsetAdjustmentBehavior = .never
        }
        
        
        
        
//        loading.startAnimating()
        loadHTML()
    }
    
    func loadHTML() {
        guard !host.isEmpty else { return  }
        let url = URL.init(string: host)
        guard let mUrl = url else { return  }
        let request = URLRequest.init(url: mUrl)
        webView.load(request)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        if message.name == "myBridge" {
//            let result = getDeviceId()
//            let script = "handleNativeResponse('\(result)')"
//            webView.evaluateJavaScript(script)
//        }
//        let result = getDeviceId()
//        let script = "handleNativeResponse('\(result)')"
//        webView.evaluateJavaScript(script)
    }
    
    // WKNavigationDelegate方法，用于处理页面加载完成时的事件
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        loading.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // 判断是否是支付宝 schema
        if let url = navigationAction.request.url, url.scheme == "alipay" {
            // 如果是支付宝 schema，则打开支付宝应用
            openAlipayApp(url: url)
            // 取消 WebView 的导航，防止在 WebView 中继续加载
            decisionHandler(.cancel)
            return
        }
        
        if let url = navigationAction.request.url, url.scheme == "wechat" {
            // 如果是支付宝 schema，则打开支付宝应用
            openAlipayApp(url: url)
            // 取消 WebView 的导航，防止在 WebView 中继续加载
            decisionHandler(.cancel)
            return
        }
        
        // 允许 WebView 继续导航
        decisionHandler(.allow)
    }
    
    // 实现以下代理方法
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
         let cred = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
         completionHandler(.useCredential, cred)
    }
    
    func getDeviceId() -> String {
//        return UIDevice.current.identifierForVendor?.uuidString ?? ""
        return UUID().uuidString
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeLeft
    }
    
    // 打开支付宝应用
    func openAlipayApp(url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
