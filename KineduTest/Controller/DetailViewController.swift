//
//  DetailViewController.swift
//  KineduTest
//
//  Created by Osmar Hernández on 14/02/20.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit

private let babyCellIdentifier = "babyCell"

class DetailViewController: UIViewController {
    
    var buildVersion: String?
    var nps: [NetPromoterScore]?

    @IBOutlet var labels: [UILabel]!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var detailSubView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var babyFaces: [UIImage] {
        var images: [UIImage] = []
        
        for i in 1...10 {
            let image = UIImage(named: "baby_\(i)")!
            images.append(image)
        }
        
        return images
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setUpLabelFonts(labels)
        detailView.configureShadowBackground()
        detailSubView.roundCorners(with: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 5)
        
        configureUI(forScore: 1)
        
        navigationItem.title = "NPS Detail " + buildVersion!
    }
    
    private func configureUI(forScore score: Int) {
        let nps = [
            self.nps!.filter { $0.userPlan == UserPlan.freemium.string },
            self.nps!.filter { $0.userPlan == UserPlan.premium.string }
        ]
        
        setUpInfo(withUsersNPS: nps, andScoreOf: score)
    }
    
    private func setUpInfo(withUsersNPS usersNPS: [[NetPromoterScore]], andScoreOf score: Int) {
        let freemiumTitle = labels[2], premiumTitle = labels[3], percentageLabel = labels[6]
        let descriptionLabel = labels[7], activitiesLabel = labels[9]
        
        freemiumTitle.text = "\(usersNPS[0].filter { $0.nps == score }.count)"
        premiumTitle.text = "\(usersNPS[1].filter { $0.nps == score }.count)"
        
        let total = usersNPS[0].filter { $0.nps == score }.count + usersNPS[1].filter { $0.nps == score }.count
        
        let mostFrequentActivities = mostFrequentElement(activityViews(score))
        
        percentageLabel.text = "\((mostFrequentActivities.value * 100) / total) %"
        descriptionLabel.text = "of the users that answered \(score) in"
        activitiesLabel.text = "\(mostFrequentActivities.key) activities"
    }
    
    private lazy var activityViews = { (score: Int) -> [Int : Int] in
        var av: [Int : Int] = [:]
        
        for element in self.nps! {
            if element.nps == score {
                if let value = av[element.activityViews] {
                    av[element.activityViews] = value + 1
                } else {
                    av[element.activityViews] = 1
                }
            }
        }
        
        return av
    }
    
    private func mostFrequentElement(_ dictionary: [Int : Int]) -> (key: Int, value: Int) {
        var current = (key: 0, value: 0)
        
        for (key, value) in dictionary {
            if value > current.value {
                current.key = key
                current.value = value
            } else if value == current.value && key > current.key {
                current.key = key
                current.value = value
            }
        }
        
        return current
    }
}

extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let babyCell = collectionView.cellForItem(at: indexPath) as? BabyCollectionViewCell {
            configureUI(forScore: Int(babyCell.babyScoreLabel.text!)!)
            babyCell.highlightSelectedCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let babyCell = collectionView.cellForItem(at: indexPath) as? BabyCollectionViewCell {
            babyCell.unhighlightDeselectedCell()
        }
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return babyFaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let babyCell = collectionView.dequeueReusableCell(withReuseIdentifier: babyCellIdentifier, for: indexPath) as! BabyCollectionViewCell
        
        babyCell.babyImageView.image = babyFaces[indexPath.item]
        babyCell.babyScoreLabel.text = "\(indexPath.item + 1)"
        
        return babyCell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let rows: CGFloat = 1
        let collectionViewHeight = collectionView.bounds.height
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let adjustedHeight = collectionViewHeight - (flowLayout.minimumInteritemSpacing * (rows - 1))
        
        let width: CGFloat = 110
        let height: CGFloat = adjustedHeight / rows
        
        return CGSize(width: width, height: height)
    }
}
