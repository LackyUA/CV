//
//  EducationVC.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 5/1/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

class EducationVC: UIViewController {

    // MARK: - Constants
    private let schoolReusableIdentifier = "SchoolCell"
    private let universityReusableIdentifier = "UniversityCell"
    private let coursesReusableIdentifier = "CoursesCell"
    
    // MARK: - Properties
    private var data = [Any]()
    
    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var bottomBar: UIView!
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
        
        parseData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        bottomBarWidthConstraint.constant = segmentControl.bounds.width / CGFloat(segmentControl.numberOfSegments)
    }
    
    // MARK: - Parser functions
    private func parseData() {
        Education().parseJSON { result in
            switch result {
                
            case .success(let data):
                self.append(data)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.title = data.title
                }
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    private func append(_ data: Education) {
        self.data.append(data.school)
        self.data.append(data.university)
        self.data.append(data.courses)
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
        pageControl.currentPage = index
    }
    
    //MARK: - Function for handling scrolling
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer <CGPoint>) {
        let x = targetContentOffset.pointee.x
        let index = Int(x / view.frame.width)
        
        pageChanged(index)
        segmentControl.selectedSegmentIndex = index
        animate()
    }

}

// MARK: - Collection view flow layout delegation
extension EducationVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}

// MARK: - COllection view data source
extension EducationVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
            
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: schoolReusableIdentifier, for: indexPath) as? SchoolCell else { return UICollectionViewCell() }
            
            if let text = data[indexPath.row] as? String {
                cell.configure(text: text)
            }
            
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: universityReusableIdentifier, for: indexPath) as? UniversityCell else { return UICollectionViewCell() }
            
            if let dictionary = data[indexPath.row] as? [String: String] {
                cell.configure(dictionary)
            }
            
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: coursesReusableIdentifier, for: indexPath) as? CoursesCell else { return UICollectionViewCell() }
            
            if let array = data[indexPath.row] as? [String] {
                cell.configure(array)
            }
            
            return cell
            
        default:
            return UICollectionViewCell()
            
        }
    }
    
}
