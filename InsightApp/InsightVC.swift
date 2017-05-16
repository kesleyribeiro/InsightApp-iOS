//
//  InsightVC.swift
//  InsightApp
//
//  Created by Kesley Ribeiro on 15/May/17.
//  Copyright © 2017 Kesley Ribeiro. All rights reserved.
//

import UIKit
import UIColor_FlatColors
import Cartography

class InsightVC: UIViewController {

    var swipeableView: ZLSwipeableView!
    
    var colors = ["Turquoise", "Green Sea", "Emerald", "Nephritis", "Peter River", "Belize Hole", "Amethyst", "Wisteria", "Wet Asphalt", "Midnight Blue", "Sun Flower", "Orange", "Carrot", "Pumpkin", "Alizarin", "Pomegranate", "Clouds", "Silver", "Concrete", "Asbestos"]
    
    var colorIndex = 0
    var loadCardsFromXib = true
    
    var leftBarButtonItem: UIBarButtonItem!
    var rightBarButtonItem: UIBarButtonItem!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        swipeableView.nextView = {
            return self.nextCardView()
        }
    }
    
    func settingsButtonTapped() {
        print("aqui..")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightButton = UIBarButtonItem(image: UIImage(named: "Star-off.png"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(settingsButtonTapped))

        navigationItem.setRightBarButton(rightButton, animated: false)
        
        navigationController?.setToolbarHidden(false, animated: false)
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        
        leftBarButtonItem = UIBarButtonItem(title: "←", style: .plain, target: self, action: #selector(leftButtonAction))
        rightBarButtonItem = UIBarButtonItem(title: "→", style: .plain, target: self, action: #selector(rightButtonAction))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let items = [flexibleSpace, leftBarButtonItem!, flexibleSpace, rightBarButtonItem!, flexibleSpace]
        toolbarItems = items
        
        swipeableView = ZLSwipeableView()
        view.addSubview(swipeableView)
        
        swipeableView.didStart = {view, location in
            print("Did start swiping view at location: \(location)")
        }
        swipeableView.swiping = {view, location, translation in
            print("Swiping at view location: \(location) translation: \(translation)")
        }
        swipeableView.didEnd = {view, location in
            print("Did end swiping view at location: \(location)")
        }
        swipeableView.didSwipe = {view, direction, vector in
            print("Did swipe view in direction: \(direction), vector: \(vector)")
        }
        swipeableView.didCancel = {view in
            print("Did cancel swiping view")
        }
        swipeableView.didTap = {view, location in
            print("Did tap at location \(location)")
        }
        swipeableView.didDisappear = { view in
            print("Did disappear swiping view")
        }
        
        constrain(swipeableView, view) { view1, view2 in
            view1.left == view2.left + 50
            view1.right == view2.right - 50
            view1.top == view2.top + 120
            view1.bottom == view2.bottom - 100
        }
    }
    
    // MARK: - Actions
    
    func leftButtonAction() {
        self.swipeableView.swipeTopView(inDirection: .Left)
    }
    
    func rightButtonAction() {
        self.swipeableView.swipeTopView(inDirection: .Right)
    }
    
    // MARK: ()
    func nextCardView() -> UIView? {
        
        func toRadian(_ degree: CGFloat) -> CGFloat {
            return degree * CGFloat(Double.pi/180)
        }
        
        func rotateAndTranslateView(_ view: UIView, forDegree degree: CGFloat, translation: CGPoint, duration: TimeInterval, offsetFromCenter offset: CGPoint, swipeableView: ZLSwipeableView) {
            
            UIView.animate(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {
                
                view.center = swipeableView.convert(swipeableView.center, from: swipeableView.superview)
                var transform = CGAffineTransform(translationX: offset.x, y: offset.y)
                transform = transform.rotated(by: toRadian(degree))
                transform = transform.translatedBy(x: -offset.x, y: -offset.y)
                transform = transform.translatedBy(x: translation.x, y: translation.y)
                view.transform = transform
            }, completion: nil)
        }
        
        swipeableView.numberOfActiveView = 10
        
        swipeableView.animateView = {(view: UIView, index: Int, views: [UIView], swipeableView: ZLSwipeableView) in
            let degree = CGFloat(sin(0.5*Double(index)))
            let offset = CGPoint(x: 0, y: swipeableView.bounds.height*0.3)
            let translation = CGPoint(x: degree*10, y: CGFloat(-index*5))
            let duration = 0.4
            
            rotateAndTranslateView(view, forDegree: degree, translation: translation, duration: duration, offsetFromCenter: offset, swipeableView: swipeableView)
        }
        
        if colorIndex >= colors.count {
            colorIndex = 0
        }
        
        let cardView = CardView(frame: swipeableView.bounds)
        cardView.backgroundColor = colorForName(colors[colorIndex])
        colorIndex += 1
        
        if loadCardsFromXib {
            
            let contentView = Bundle.main.loadNibNamed("CardContentView", owner: self, options: nil)?.first! as! UIView
            contentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.backgroundColor = cardView.backgroundColor
            cardView.addSubview(contentView)
            
            constrain(contentView, cardView) { view1, view2 in
                view1.left == view2.left
                view1.top == view2.top
                view1.width == cardView.bounds.width
                view1.height == cardView.bounds.height
            }
        }
        return cardView
    }
    
    func colorForName(_ name: String) -> UIColor {
        let sanitizedName = name.replacingOccurrences(of: " ", with: "")
        let selector = "flat\(sanitizedName)Color"
        return UIColor.perform(Selector(selector)).takeUnretainedValue() as! UIColor
    }
    
}
