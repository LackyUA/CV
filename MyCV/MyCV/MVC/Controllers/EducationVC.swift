//
//  EducationVC.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 5/1/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

class EducationVC: UIViewController {

    // MARK: - Constabts
    private let reusableIdentifier = "EducationCell"
    
    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var bottomBar: UIView!
    @IBOutlet private weak var helloLabel: UILabel!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    @IBOutlet private weak var segmentControl: UISegmentedControl! {
        didSet {
            // Segment customization
            segmentControl.backgroundColor = .clear
            segmentControl.tintColor = .clear
            
            segmentControl.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont(name: "GillSans-Italic", size: 18) ?? UIFont.boldSystemFont(ofSize: 18),
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                ], for: .normal)
            
            segmentControl.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont(name: "GillSans-Italic", size: 18) ?? UIFont.boldSystemFont(ofSize: 18),
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.09048522819, green: 0.7226287412, blue: 0.9303202025, alpha: 1)
                ], for: .selected)
        }
    }
    
    // MARK: - Constraints
    @IBOutlet private weak var bottomBarWidthConstraint: NSLayoutConstraint!
    
    // MARK: - Actions
    @IBAction func valueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        
        case 0:
            changeSegmentValue(sender)
            
        case 1:
            changeSegmentValue(sender)
            
        case 2:
            changeSegmentValue(sender)
            
        default:
            break
            
        }
        
        animate()
    }
    
    // MARK: - Life cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomBarWidthConstraint.constant = segmentControl.bounds.width / 3
    }
    
    
    
    // MARK: - Helpers
    private func animate() {
        UIView.animate(withDuration: 0.3) {
            self.bottomBar.frame.origin.x = (self.segmentControl.frame.width / CGFloat(self.segmentControl.numberOfSegments)) * CGFloat(self.segmentControl.selectedSegmentIndex)
        }
    }
    
    private func changeSegmentValue(_ sender: Any) {
        if let sender = sender as? UISegmentedControl {
            pageChanged(sender.selectedSegmentIndex)
            collectionView.scrollToItem(at: IndexPath(item: sender.selectedSegmentIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    private func pageChanged(_ index: Int) {
        helloLabel.text = segmentControl.titleForSegment(at: index)
        pageControl.currentPage = index
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                            withVelocity velocity: CGPoint,
                                            targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let index = Int(x / view.frame.width)
        
        pageChanged(index)
        segmentControl.selectedSegmentIndex = index
        animate()
    }

}

// MARK: - Collection view delegation
extension EducationVC: UICollectionViewDelegate {
    
    
    
}

// MARK: - COllection view data source
extension EducationVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as? EducationCell else { return UICollectionViewCell() }
        
        switch indexPath.row {
        case 0:
            cell.backgroundColor = .red
        case 1:
            cell.backgroundColor = .blue
        default:
            cell.backgroundColor = .yellow
        }
        
        return cell
    }
    
}
