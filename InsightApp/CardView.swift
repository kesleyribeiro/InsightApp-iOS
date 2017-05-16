//
//  CardView.swift
//  ZLSwipeableViewSwiftDemo
//
//  Created by Zhixuan Lai on 5/24/15.
//  Copyright (c) 2015 Zhixuan Lai. All rights reserved.
//

import UIKit
import DOFavoriteButton
import YBAlertController
import Social

class CardView: UIView {

    @IBOutlet weak var nomeAutorLbl: UILabel!
    @IBOutlet weak var descricaoFraseTxt: UITextView!
    @IBOutlet weak var favoritoBtn: DOFavoriteButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)        
        setup()
    }

    func setup() {

        // Shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowRadius = 4.0
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        // Corner Radius
        layer.cornerRadius = 10.0;
    }
    
    @IBAction func compartilharFrase(_ sender: Any) {
        
        // Cria o Alerta com o título e mensagem padrão
        let alerta = YBAlertController(title: "Compartilhar frase", message: "Onde deseja compartilhar?", style: .alert)
        
        // Adicionar o botão 'Facebook'
        alerta.addButton(UIImage(named: "Facebook-icon"), title: "Facebook", action: {
            print("Botão 'Facebook' foi selecionado")
        
            // Check if Facebook is available. Otherwise, display an error message
            guard SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) else {

                let alertMessage = UIAlertController(title: "Facebook desabilitado", message: "Você não está logado com sua conta do Facebook. Por favor, acesse Settings > Facebook para entrar.", preferredStyle: .alert)
                
                alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                self.present(alertMessage, animated: true, completion: nil)
                
                return
            }
            
            // Display Tweet Composer
            if let fbComposer = SLComposeViewController(forServiceType: SLServiceTypeFacebook) {

                fbComposer.setInitialText("Autor: " + self.nomeAutorLbl.text! + "\n" + self.descricaoFraseTxt.text!)
                fbComposer.add(URL(string: "https://www.appcoda.com"))
                self.present(fbComposer, animated: true, completion: nil)
            }
        })
        
        // Adicionar o botão 'Instagram'
        alerta.addButton(UIImage(named: "Instagram-icon"), title: "Instagram", action: {
            print("Botão 'Instagram' foi selecionado")
        })
        
        // Adicionar o botão 'Whatsapp'
        alerta.addButton(UIImage(named: "Whatsapp-icon"), title: "Whatsapp", action: {
            print("Botão 'Whatsapp' foi selecionado")
        })
        
        // Adicionar o botão 'Enviar por Email'
        alerta.addButton(UIImage(named: "Email-icon"), title: "Email", action: {
            print("Botão 'Email' foi selecionado")
        })
        
        // touch outside the alert to dismiss
        alerta.touchingOutsideDismiss = true
        
        // Adicionar o botão 'Cancelar'
        alerta.cancelButtonTitle = "Cancelar"
        
        // Mostra o alerta
        alerta.show()
    }
    
    @IBAction func favoritarFrase(_ sender: DOFavoriteButton) {
    
        if sender.isSelected {
            // deselect
            sender.deselect()
        } else {
            // select with animation
            sender.select()
        }
    }
}
