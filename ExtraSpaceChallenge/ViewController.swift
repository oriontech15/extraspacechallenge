//
//  ViewController.swift
//  ExtraSpaceChallenge
//
//  Created by orion on 8/6/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath)
        
        cell.backgroundColor = UIColor.init(red: CGFloat.random(in: 0..<1.0), green: CGFloat.random(in: 0..<1.0), blue: CGFloat.random(in: 0..<1.0), alpha: 1.0)
        
        return cell
    }
}

