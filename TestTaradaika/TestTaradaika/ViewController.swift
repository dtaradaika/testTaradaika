//
//  ViewController.swift
//  TestTaradaika
//
//  Created by Dmytro Taradaika on 10/08/2022.
//

import UIKit

//class DataSource {
//
//    let lock = NSLock()
//    var itemsCounter: Int = 0
//
//    func append() {
//        lock.lock()
//        itemsCounter = itemsCounter + 1
//    }
//
//
//}

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var itemsCounter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    public func addItem() {
        DispatchQueue.main.async {
            
            self.itemsCounter = self.itemsCounter + 1
            
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: IndexPath(item: self.itemsCounter - 1, section: 0), at: .right, animated: true)
        }
    }
    
    public func removeItem(index: Int) {
        
        DispatchQueue.main.async {
            self.itemsCounter = self.itemsCounter - 1
            self.collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
        }
        
    }
    
    @IBAction func tapAddItem() {
        addItem()
    }


}

extension ViewController: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsCounter
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        removeItem(index: indexPath.item)
    }
}



