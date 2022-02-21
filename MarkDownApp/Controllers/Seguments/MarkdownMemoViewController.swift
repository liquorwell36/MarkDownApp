//
//  MemoViewController.swift
//  MarkDownApp
//
//  Created by kosuke sakai on 2022/02/17.
//

import Foundation
import UIKit

class MarkdownMemoViewController: UIViewController {
    
    let inputTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        setupKeyboard()
        print("MarkdownMemoVC viewDidloaded")
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.view.isUserInteractionEnabled = true
        
    }
    
    //MARK: - inputTextView UI setup
    private func setupTextView() {
        inputTextView.delegate = self
        inputTextView.keyboardType = .default
        inputTextView.layer.cornerRadius = 20
        inputTextView.layer.borderWidth = 1
        inputTextView.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        inputTextView.backgroundColor = .white
        inputTextView.text = "Let's edit TextView!"
        Text.shared.text = inputTextView.text
        inputTextView.font = UIFont.systemFont(ofSize: 18.0)
        
        inputTextView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 8)
        self.view.addSubview(inputTextView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupViews(uiView: inputTextView)
    }
    
    func setupViews(uiView: UIView) {
        let safeArea = view.safeAreaInsets
        
        let partsArea_W = UIScreen.main.bounds.width - safeArea.left - safeArea.right
        let partsArea_H = UIScreen.main.bounds.height - safeArea.top - safeArea.bottom
        
        let margin_X = round(partsArea_W * 0.05)
        let margin_Y = round(partsArea_H * 0.05)

        let textView_W = partsArea_W - margin_X * 2
        let textView_H = partsArea_H - margin_Y * 2 - 110
        let textView_X = margin_X
        let textView_Y = UIScreen.main.bounds.height - textView_H - safeArea.bottom - margin_Y
        
        uiView.frame.size = CGSize(width: textView_W, height: textView_H)
        uiView.frame.origin = CGPoint(x: textView_X, y: textView_Y)
    }
    
    //MARK: - keyborad UI setup
    func setupKeyboard() {
        let kbToolbar = UIToolbar()
        
        kbToolbar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let kbDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(kbDoneTaped))
        kbToolbar.items = [spacer, kbDoneButton]
        inputTextView.inputAccessoryView = kbToolbar
    }
    
    @objc func kbDoneTaped() {
        view.endEditing(true)
    }
    
    @objc func kbWillShow(notification: NSNotification?) {
        var activeView: UIView?
        
        for sub in view.subviews {
            if sub.isFirstResponder {
                activeView = sub
            }
        }
        let userInfo = notification?.userInfo!
        let kbScreenEndFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        guard let actView = activeView else { return }
        let txtLimit = actView.frame.origin.y + actView.frame.height
        let kbLimit = view.bounds.height - kbScreenEndFrame.size.height
        
        let offset = kbLimit - txtLimit - 10
        if offset > 0 {
            print("キーボードがかぶっていない")
            return
        }
        
        print("offset: \(offset)")
        
        //アニメーションさせる時間を取得
        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: duration!) {
            let transform = CGAffineTransform(translationX: 0, y: offset)
            self.view.transform = transform
        }
    }
    
    @objc func kbWillHide(notification: Notification?) {
        //アニメーションさせる時間を取得
        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!) {
            self.view.transform = CGAffineTransform.identity
        }
    }
}

extension MarkdownMemoViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let inputText = inputTextView.text else { return }
        Text.shared.text = inputText
    }
}
