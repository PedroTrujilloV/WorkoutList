//
//  WorkoutListCollectionViewFlowLayout.swift
//  WorkoutListApp
//
//  Created by Pedro Enrique Trujillo Vargas on 7/10/21.
//

import UIKit

class WorkoutListCollectionViewFlowLayout: UICollectionViewFlowLayout {

    init(frame:CGRect) {
        super.init()
        self.sectionInset = UIEdgeInsets(top: 10, left: CGFloat.FlowLayout.Spacing.normal, bottom: 10, right: CGFloat.FlowLayout.Spacing.normal)
        self.minimumInteritemSpacing = CGFloat.FlowLayout.Spacing.normal
        self.minimumLineSpacing = CGFloat.FlowLayout.Spacing.normal
        let extraSpace = ( CGFloat( Int.FlowLayout.columns.double ) * CGFloat.FlowLayout.Spacing.normal ) + CGFloat.FlowLayout.Spacing.normal
        let sideLenght = ( frame.width - extraSpace ) / CGFloat.FlowLayout.Spacing.normal
        let textAreaHeight = sideLenght // 2
        self.itemSize = CGSize(width: sideLenght, height: sideLenght + textAreaHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

