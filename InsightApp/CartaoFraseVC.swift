//
//  CartaoFraseVC.swift
//  InsightApp
//
//  Created by Kesley Ribeiro on 15/May/17.
//  Copyright © 2017 Kesley Ribeiro. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

private var numeroDeFrases: Int = 30

class CartaoFraseVC: UIView {

    var frases = [Frase]()
    var frase: Frase!
    var favoritosRef: FIRDatabaseReference!

    @IBOutlet weak var nomeAutorLbl: UILabel!
    @IBOutlet weak var descricaoFraseTxt: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        DataService.ds.REF_FRASES.observe(.value, with: { (snapshot) in
            
            self.frases = []
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("[SNAP] \(snap)")
                    if let dicionarioFrase = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let frase = Frase(fraseKey: key, fraseData: dicionarioFrase)
                        self.frases.append(frase)
                    }
                }
            }            
        })        
        
        self.nomeAutorLbl.text = frase.autor
        self.descricaoFraseTxt.text = frase.descricao
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()     
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)        

        setup()
    }
    
    func setup() {
        
        // Sombra
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowRadius = 4.0
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        // Bordas
        layer.cornerRadius = 10.0
    }
}
