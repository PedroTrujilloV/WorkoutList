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
        return imageV
    }()
    
    private var nameLable: UILabel =  {
        let label = UILabel()
        label.text  = "No Name"
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 18)//UIFont(name: "Roboto-Bold", size: 24)
        label.textColor = UIColor.nameTextColor
        label.numberOfLines = 2
        return label
    }()
    
    private var descriptionLabel: UITextView = {
        let textView = UITextView()
        textView.text  = "No description"
        textView.textAlignment = .center
        textView.font = UIFont(name: "AvenirNext-Regular", size: 14)
        textView.textColor = UIColor.descriptionTextColor
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
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
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 14.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var stackView :UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 12.0
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
        setupStyle()
    }
    
    private func setupStyle() {
        self.backgroundColor = UIColor.systemBackground
    }
       
    private func setupStackView(){
        setupImageViewConstraints()
        setupTextConstraints()
        setupTextStackView()
        
        stackView.addArrangedSubview(thumbnailImageView)
        stackView.addArrangedSubview(textStackView)
        self.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    private func setupImageViewConstraints(){
        let proportion:CGFloat = 0.5
        thumbnailImageView.heightAnchor.constraint(equalToConstant: self.frame.width * proportion).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalToConstant: self.frame.width * proportion).isActive = true
    }
       
    private func setupTextConstraints(){
        nameLable.widthAnchor.constraint(equalToConstant: self.frame.width-20).isActive = true
        nameLable.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: self.frame.width-30).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
        otherInfo.widthAnchor.constraint(equalToConstant: self.frame.width-25).isActive = true
//        otherInfo.heightAnchor.constraint(equalToConstant: 95.0).isActive = true
    }
    
    private func setupTextStackView() {
        textStackView.addArrangedSubview(nameLable)
        textStackView.addArrangedSubview(descriptionLabel)
        textStackView.addArrangedSubview(otherInfo)
    }
    
    public func set(from viewModel:ExerciseViewModel) {
        nameLable.text = viewModel.name
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
