//
//  MarkdownViewController.swift
//  MarkDownApp
//
//  Created by kosuke sakai on 2022/02/17.
//

import Foundation
import UIKit
import MarkdownView


class MarkdownPreviewViewController: UIViewController {
    
    let markdownView = MarkdownView()
    var text = Text.shared.text
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(markdownView)
        print("viewDidload")
        markdownView.backgroundColor = .white
        setupViews(uiView: markdownView)
    }
    
    func setupViews(uiView: UIView) {
        let safeArea = view.safeAreaInsets
        
        let partsArea_W = UIScreen.main.bounds.width
        let partsArea_H = UIScreen.main.bounds.height
        let margin_X = round(partsArea_W * 0.05)
        let margin_Y = round(partsArea_H * 0.05)

        let textView_W = partsArea_W - margin_X * 2
        let textView_H = partsArea_H - margin_Y * 2 - 85
        let textView_X = margin_X
        let textView_Y = UIScreen.main.bounds.height - textView_H - safeArea.bottom - margin_Y
        
        uiView.frame.size = CGSize(width: textView_W, height: textView_H)
        uiView.frame.origin = CGPoint(x: textView_X, y: textView_Y)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        markdownView.load(markdown: text)
    }
    
    func foo(text: String) {
        markdownView.load(markdown: text)
    }
}
