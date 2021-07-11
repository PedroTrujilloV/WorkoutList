//
//  WorkoutListExerciseDetailView.swift
//  WorkoutListApp
//
//  Created by Pedro Enrique Trujillo Vargas on 7/10/21.
//

import UIKit
import Combine


class WorkoutListExerciseDetailView: UIView {
    
    private var cancellable: AnyCancellable?
    private var url:String = ""

    private var thumbnailImageView:UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFit
        imageV.layer.cornerRadius = 5
        imageV.layer.masksToBounds = true
        imageV.image = UIImage(named: "logo")
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    private var nameLabel: UILabel =  {
        let label = UILabel()
        label.text  = "No Name"
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        label.textColor = UIColor.nameTextColor
        label.numberOfLines = 2
        return label
    }()
    
    private var descriptionLabel: UITextView = {
        let textView = UITextView()
        textView.text  = "No description"
        textView.textAlignment = .center
        textView.font = UIFont(name: "AvenirNext-Regular", size: 15)
        textView.textColor = UIColor.descriptionTextColor
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = true
        return textView
    }()
    
    private var otherInfo:UILabel = {
       let label = UILabel()
        label.text  = "No Other Info."
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Light", size: 14)
        label.numberOfLines = 6
        return label
    }()

    
    private var textStackView :UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = .fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var stackView :UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = .fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    private let defaultImage = UIImage(named: "logo")

    init(frame: CGRect, offerViewModel:  ExerciseViewModel) {
        super.init(frame: frame)
        setup()
        set(from: offerViewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit  {
        cancellable?.cancel()
    }
    
    private func setup(){
        setupStackView()
        setupTextStackView()
        setupImageViewConstraints()
        setupTextConstraints()
        setupStyle()
    }
    
    private func setupStyle() {
        self.backgroundColor = UIColor.systemBackground
    }
       
    private func setupStackView(){

        self.addSubview(stackView)
        stackView.addArrangedSubview(thumbnailImageView)
        stackView.addArrangedSubview(textStackView)
        
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 55.0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30.0).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    
    private func setupTextStackView() {
        textStackView.addArrangedSubview(nameLabel)
        textStackView.addArrangedSubview(descriptionLabel)
        textStackView.addArrangedSubview(otherInfo)
        textStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
    }
    
    private func setupImageViewConstraints(){
        thumbnailImageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.4).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.9).isActive = true
    }
       
    private func setupTextConstraints(){
        nameLabel.widthAnchor.constraint(equalTo: textStackView.widthAnchor, multiplier: 0.9).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: textStackView.heightAnchor, multiplier: 0.2).isActive = true
        
        descriptionLabel.widthAnchor.constraint(equalTo: textStackView.widthAnchor, multiplier: 0.9).isActive = true
        descriptionLabel.heightAnchor.constraint(equalTo: textStackView.heightAnchor, multiplier: 0.45).isActive = true
        
        otherInfo.widthAnchor.constraint(equalTo: textStackView.widthAnchor, multiplier: 0.9).isActive = true
        otherInfo.heightAnchor.constraint(equalTo: textStackView.heightAnchor, multiplier: 0.35).isActive = true
    }

    
    public func set(from viewModel:ExerciseViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.attributedText = viewModel.description.htmlToAttributedString
        viewModel.getOtherInfo { [weak self] otherInfoString in
            DispatchQueue.main.async { [weak self] in
                self?.otherInfo.text = otherInfoString
            }
        }
        bind(viewModel)
    }
    
    private func bind(_ viewModel: ExerciseViewModel) {
        if let imgUrl = URL(string: viewModel.fullImage ){
            cancellable = ImageLoader.shared.loadImage(from: imgUrl)
                .handleEvents( receiveCompletion: { [weak self] (completion) in
                    DispatchQueue.main.async {
                        let margin:CGFloat = 16
                        self?.thumbnailImageView.image = self?.thumbnailImageView.image?.withInset(UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
                    }
                })
                .assign(to: \.thumbnailImageView.image, on: self )
        }
    }
    
}
