//
//  avatarPickerVC.swift
//  Smack
//
//  Created by Zeyad Taher on 2/2/19.
//  Copyright © 2019 Zeyad Taher. All rights reserved.
//

import UIKit

class avatarPickerVC: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //outlets
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //VARs
    var AvatarType = avatarType.dark
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? avatarPickerCell {
            cell.configureCell(index: indexPath.item, type: AvatarType)
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if AvatarType == .dark{
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        }else{
             UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func avtarPickerPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentControllerPressed(_ sender: Any) {
        if AvatarType == .dark {
            AvatarType = .light
        }else{
            AvatarType = .dark
        }
        collectionView.reloadData()
    }
    

}
