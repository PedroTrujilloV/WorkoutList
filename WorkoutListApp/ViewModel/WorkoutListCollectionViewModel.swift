//
//  WorkoutListCollectionViewModel.swift
//  WorkoutListApp
//
//  Created by Pedro Enrique Trujillo Vargas on 7/10/21.
//

import Foundation


class WorkoutListCollectionViewModel: NSObject {
    
    public var title = "Workout List"
    private var dataSource: DataSource?
    public var dataSourceList:Array<ExerciseViewModel> = []
    public weak var delegate: WorkoutListCollectionViewControllerDelegate?
    
    override init() {
        super.init()
        dataSource = DataSource(delegate: self)
    }
    
}

extension WorkoutListCollectionViewModel: DataSourceDelegate {
    func dataSourceDidLoad(dataSource: Array<ExerciseViewModel>) {
        self.dataSourceList = dataSource
        self.delegate?.updateCollectionView(with: dataSource)
    }
}
