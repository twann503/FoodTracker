//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Thuan on 3/3/18.
//  Copyright © 2018 Thuan. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

    
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectedState()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet{
            setupButtons()
        }
    }
    
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
        
    }
    
    //MARK: Button Action
    @objc func ratingButtonTapped(button: UIButton){
        
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        let selectedRating = index + 1
        
        if selectedRating == rating {
            //if selected matches the selected set it to 0
            rating = 0
        } else {
            rating = selectedRating
        }
        
        
    }
    

    //MARK: Private Methods
    private func setupButtons() {
        
        
        //clear existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        //Load Button Images
        let bundle = Bundle(for: type(of:self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        
        
        for _ in 0..<starCount{
            
            let button = UIButton()
            button.setImage(emptyStar, for : .normal)
            button.setImage(filledStar, for : .selected)
            button.setImage(highlightedStar, for : .highlighted)
            
            //Constraints
            
            //need because custom size need to turn auto sizing off
            button.translatesAutoresizingMaskIntoConstraints = false
            
            //sizing for buttons
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //setup button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            //Adds button to the stack
            addArrangedSubview(button)
            
            //Add button to array
            ratingButtons.append(button)
        }
        updateButtonSelectedState()
    }
    
    private func updateButtonSelectedState() {
        for (index, button) in ratingButtons.enumerated(){
            button.isSelected = index < rating
            
        }
    }
    
    
    
}
