//
//  InputTextViewController.swift
//  MarkDownApp
//
//  Created by kosuke sakai on 2022/02/17.
//

import Foundation
import UIKit
import MarkdownView

class InputTextViewController: UIViewController {
    
    var MarkdownMemoVC: MarkdownMemoViewController = MarkdownMemoViewController()
    var MarkdownPreviewVC: MarkdownPreviewViewController = MarkdownPreviewViewController()
    
    @IBOutlet weak var segmentButton: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        segmentButton.setTitle("Markdown", forSegmentAt: 0)
        segmentButton.setTitle("PreView", forSegmentAt: 1)
        
        self.addChild(MarkdownPreviewVC)
        self.addChild(MarkdownMemoVC)
        
        self.view.addSubview(MarkdownPreviewVC.view)
        self.view.addSubview(MarkdownMemoVC.view)
        
        MarkdownMemoVC.didMove(toParent: self)
        MarkdownPreviewVC.didMove(toParent: self)
        
        self.view.bringSubviewToFront(segmentButton)
    }
    
    @IBAction func segmentButton(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.view.bringSubviewToFront(MarkdownMemoVC.view)
            self.view.bringSubviewToFront(segmentButton)
        case 1:
            self.view.bringSubviewToFront(MarkdownPreviewVC.view)
            self.view.bringSubviewToFront(segmentButton)
            MarkdownPreviewVC.foo(text: Text.shared.text)
        default:
            break
        }
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
    }
}
