//
//  ViewController.swift
//  MarkDownApp
//
//  Created by kosuke sakai on 2022/02/17.
//

import UIKit

class DisplayNotesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createMemoButton() {
        let InputTextViewController = self.storyboard?.instantiateViewController(withIdentifier: "inputTextViewController") as! InputTextViewController
        self.navigationController?.pushViewController(InputTextViewController, animated: true)
    }


}

