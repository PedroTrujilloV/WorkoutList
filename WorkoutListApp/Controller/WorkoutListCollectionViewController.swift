//
//  WorkoutListCollectionViewController.swift
//  WorkoutListApp
//
//  Created by Pedro Enrique Trujillo Vargas on 7/10/21.
//

import UIKit

protocol WorkoutListCollectionViewControllerDelegate: NSObject {
    func updateCollectionView(with list: Array<ExerciseViewModel>)
}

class WorkoutListCollectionViewController: UICollectionViewController  {
    
    
    private var viewModel = WorkoutListCollectionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        viewModel.delegate = self
        navigationItem.title = viewModel.title
        collectionView = WorkoutListCollectionView(frame: collectionView.frame)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }

}

extension WorkoutListCollectionViewController: WorkoutListCollectionViewControllerDelegate {
    func updateCollectionView(with list: Array<ExerciseViewModel>) {
        self.collectionView?.reloadData()
    }
}

extension WorkoutListCollectionViewController { // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSourceList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == viewModel.dataSourceList.count - 1 { // last cell
            viewModel.paginate()
        }
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutListCollectionViewCell.reuserIdentifier, for: indexPath) as?
            WorkoutListCollectionViewCell {
            let vm = viewModel.dataSourceList[indexPath.item]
            cell.set(from: vm)
            return cell
        } else {
            print("Problem at dequeueReusableCell for WorkoutListCollectionViewCell")
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutListCollectionViewCell.reuserIdentifier, for: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let exerciseVM = viewModel.dataSourceList[indexPath.row]
        let detailVC = WorkoutListExerciseDetailViewController(exerciseVM)
        presentDetailViewController(detailVC)
        
    }
    
    private func presentDetailViewController(_ detailVC: WorkoutListExerciseDetailViewController) {
       let nc = UINavigationController(rootViewController: detailVC)
       nc.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
       nc.navigationBar.shadowImage = UIImage()
       nc.navigationBar.isTranslucent = true
       nc.view.backgroundColor = UIColor.clear

       self.present(nc, animated: true) {
           //do something
       }
    }
}


