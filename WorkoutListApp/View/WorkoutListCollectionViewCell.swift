//
//  WorkoutListCollectionViewCell.swift
//  WorkoutListApp
//
//  Created by Pedro Enrique Trujillo Vargas on 7/10/21.
//

import Foundation


import UIKit
import Combine

class WorkoutListCollectionViewCell: UICollectionViewCell {
    static let reuserIdentifier: String = "WorkoutListCollectionViewCell"
    private var cancellables: Array<AnyCancellable> = []
    private static let processingQueue = DispatchQueue(label: "processingQueue")
    private let heightProportion:CGFloat = 0.65
    private let defaultImage = UIImage(named: "logo")
    private let likeStateImageView = UIImageView(image: UIImage(systemName: "heart.fill") )
    private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    private let stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = .fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing  = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let textStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = .fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 3.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var thumbnailImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.cellImageBackgroundColor
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text  = "No name"
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        label.textColor = UIColor.nameTextColor
        label.numberOfLines = 2
        return label
    }()
    
    private var descriptionLabel: UITextView = {
        let textView = UITextView()
        textView.text  = "No description"
        textView.textAlignment = .center
        textView.font = UIFont(name: "AvenirNext-Regular", size: 11)
        textView.textColor = UIColor.descriptionTextColor
        textView.isEditable = false
        textView.isSelectable = false
        textView.isUserInteractionEnabled = true
        textView.isMultipleTouchEnabled = true
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit  {
        self.cancel()
    }
    
    private func cancel(){
        _ = cancellables.map{ $0.cancel()}
    }
    
    func setup(){
        setupStackView()
        setupImageViewConstraints()
        setupTextViewConstraints()
        setupIcons()
    }
       
    private func setupStackView(){
        
        self.addSubview(stackView)
        stackView.addArrangedSubview(thumbnailImageView)
        stackView.addArrangedSubview(textStackView)
        activityIndicator.startAnimating()
        
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    private func setupImageViewConstraints(){
        thumbnailImageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.5).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.9).isActive = true
    }
    
    private func setupTextViewConstraints(){
        textStackView.addArrangedSubview(nameLabel)
        textStackView.addArrangedSubview(descriptionLabel)
        
        nameLabel.widthAnchor.constraint(equalTo: textStackView.widthAnchor, multiplier: 0.9).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: textStackView.widthAnchor, multiplier: 0.9).isActive = true
        descriptionLabel.heightAnchor.constraint(equalTo: textStackView.heightAnchor, multiplier: 0.6).isActive = true
    }
    
    private func setupIcons(){
        likeStateImageView.tintColor = UIColor.brandColor
        likeStateImageView.isHidden = true
        let yPos:CGFloat = self.frame.size.height - (self.frame.size.height * heightProportion)
        activityIndicator.center = CGPoint(x: self.frame.size.width/2, y: yPos)
        self.addSubview(activityIndicator)
        self.addSubview(likeStateImageView)
    }

        
    public func set(from viewModel:  ExerciseViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.attributedText = viewModel.description.htmlToDynamicAttributedString(color: .descriptionTextColor,
                                                                                              font: UIFont(name: "AvenirNext-Regular", size: 11)!)
        bindImage(viewModel)
    }
    
    private func bindImage(_ viewModel: ExerciseViewModel) {
        viewModel.getImageURL { [weak self] url in
            DispatchQueue.main.async { [weak self] in
                self?.cancellables.append(
                    ImageLoader.shared.loadImage(from: url)
                        .handleEvents(receiveSubscription: { [weak self] (subscription) in
                                DispatchQueue.main.async {
                                    self?.activityIndicator.startAnimating()
                                }
                            }, receiveCompletion: { [weak self] (completion) in
                                DispatchQueue.main.async {
                                    self?.activityIndicator.stopAnimating()
                                    let margin:CGFloat = 10
                                    self?.thumbnailImageView.image = self?.thumbnailImageView.image?.withInset(UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
                                }
                            }, receiveCancel: { [weak self]  in
                                DispatchQueue.main.async {
                                    self?.activityIndicator.stopAnimating()
                                }
                        })
                        .assign(to: \.image, on: self!.thumbnailImageView )
                )
            }
        }

    }
    
    override func prepareForReuse() {
        thumbnailImageView.image = defaultImage
        self.likeStateImageView.isHidden = true
        self.descriptionLabel.text = ""
        self.nameLabel.text = ""
        self.cancel()
    }
}
