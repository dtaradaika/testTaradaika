//
//  ViewController.swift
//  TestTaradaika
//
//  Created by Dmytro Taradaika on 10/08/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var itemsCounter: Int = 0
    
    var cellCenter: CGPoint = .zero
    var selectedCell: UICollectionViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(moveCell(gesture:)))
        gesture.delegate = self
        collectionView.addGestureRecognizer(gesture)
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

    @objc func moveCell(gesture: UIPanGestureRecognizer) {
      
        var translation: CGPoint = .zero
        
        if let selectedCell = selectedCell {
            translation = gesture.translation(in: selectedCell)
        }
            
        if gesture.state == .began {
            
            guard let indexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)),
                  let cell = collectionView.cellForItem(at: indexPath) else {
                return
            }
            
            selectedCell = cell
            cellCenter = cell.center
        }
        
        selectedCell?.center = CGPoint(x: cellCenter.x, y: cellCenter.y + translation.y)
        
        if gesture.state == .cancelled {
            selectedCell?.center = cellCenter
        }
        
        if gesture.state == .ended {
            if translation.y > 75 || translation.y < -75 {
                
                guard let cell = selectedCell, let index = collectionView.indexPath(for: cell) else {
                    return
                }
                
                removeItem(index: index.item)
            } else {
                selectedCell?.center = cellCenter
            }
        }
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

extension ViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
   
}



