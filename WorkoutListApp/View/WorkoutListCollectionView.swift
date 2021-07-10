//
//  WorkoutListCollectionView.swift
//  WorkoutListApp
//
//  Created by Pedro Enrique Trujillo Vargas on 7/10/21.
//

import Foundation
import UIKit

class WorkoutListCollectionView: UICollectionView {

    init(frame: CGRect) {
        let layout = WorkoutListCollectionViewFlowLayout(frame: frame)
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.alwaysBounceVertical = true
        self.backgroundColor = .systemBackground
        self.register(WorkoutListCollectionViewCell.self, forCellWithReuseIdentifier: WorkoutListCollectionViewCell.reuserIdentifier)
    }

}
