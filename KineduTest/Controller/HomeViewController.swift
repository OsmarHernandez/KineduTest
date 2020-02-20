//
//  ViewController.swift
//  KineduTest
//
//  Created by Osmar Hernández on 13/02/20.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit

private let detailSegueIdentifier = "detailSegue"

class HomeViewController: UIViewController {

    var nps: [NetPromoterScore]?
    
    @IBOutlet var labels: [UILabel]!
    @IBOutlet weak var alertBackground: UIView!
    @IBOutlet weak var customSegmentedControl: CustomSegmentedControl!
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    
    private lazy var npsForBuildVersion = { (buildVersion: String) in
        return self.nps!.filter { $0.build.version == buildVersion }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setUpLabelFonts(labels)
        alertBackground.configureShadowBackground()
        
        if view.frame.height > 667.0 {
            headerTopConstraint.constant = 46
        }
        
        listenToCustomSegmentedControlChanges()
    }
    
    private let score = { (usersNPS: [NetPromoterScore]) in
        return (usersNPS.filter { $0.nps >= 9 }.count * 100 / usersNPS.count) -
            (usersNPS.filter { $0.nps <= 6 }.count * 100 / usersNPS.count)
    }
    
    private func configureUI(forBuildVersion buildVersion: String) {
        guard let _ = nps else { return }
        
        let freemiumTitle = labels[3], freemiumDescription = labels[4]
        let premiumTitle = labels[6], premiumDescription = labels[7]
        
        let usersNPS = { (userPlan: String) in
            return self.npsForBuildVersion(buildVersion).filter { $0.userPlan == userPlan }
        }
        
        setUpInfo(forLabel: freemiumTitle, andLabel: freemiumDescription, withUsersNPS: usersNPS(UserPlan.freemium.string))
        setUpInfo(forLabel: premiumTitle, andLabel: premiumDescription, withUsersNPS: usersNPS(UserPlan.premium.string))
    }
    
    private func setUpInfo(forLabel title: UILabel, andLabel description: UILabel, withUsersNPS nps: [NetPromoterScore]) {
        title.text = "\(score(nps))"
        description.text = "Out of \(nps.count)"
        
        title.textColor = score(nps) < 70 ? #colorLiteral(red: 0.8980392157, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0.4588235294, green: 0.7176470588, blue: 0.3254901961, alpha: 1)
    }
    
    func handleNetPromoterScoresRequest(_ netPromoterScores: [NetPromoterScore]?, error: Error?) {
        guard let netPromoterScores = netPromoterScores else {
            print("Error: \(error!)")
            return
        }
        
        DispatchQueue.main.async {
            self.nps = netPromoterScores
            self.configureUI(forBuildVersion: self.customSegmentedControl.titleForSelectedSegment!)
        }
    }
    
    private func listenToCustomSegmentedControlChanges() {
        customSegmentedControl.actionForSelectedSegment = { sender in
            self.configureUI(forBuildVersion: sender.currentTitle!)
        }
    }
    
    @IBAction func moreDetailsAction(_ sender: UIButton) {
        performSegue(withIdentifier: detailSegueIdentifier, sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.buildVersion = customSegmentedControl.titleForSelectedSegment
        detailViewController.nps = npsForBuildVersion(customSegmentedControl.titleForSelectedSegment!)
    }
}

