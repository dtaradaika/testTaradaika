//
//  ViewController.swift
//  TestTaradaika
//
//  Created by Dmytro Taradaika on 10/08/2022.
//

import UIKit

//class DataSource {
//
//    var items: []
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
    
    func addItem() {
        itemsCounter = itemsCounter + 1
        collectionView.reloadData()
        
        
        collectionView.scrollToItem(at: IndexPath(item: itemsCounter - 1, section: 0), at: .right, animated: true)
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
        
        itemsCounter = itemsCounter - 1
        collectionView.deleteItems(at: [indexPath])
    }
}



