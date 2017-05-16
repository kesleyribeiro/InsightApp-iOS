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
import Social
import YBAlertController
import Firebase

class InsightVC: UIViewController {

    var frases = [Frase]()
    var swipeableView: ZLSwipeableView!

    var cores = ["Turquoise", "Green Sea", "Emerald", "Nephritis", "Peter River", "Belize Hole", "Amethyst", "Wisteria", "Wet Asphalt", "Midnight Blue", "Sun Flower", "Orange", "Carrot", "Pumpkin", "Alizarin", "Pomegranate", "Clouds", "Silver", "Concrete", "Asbestos"]

    var indiceCores = 0
    var carregarCartoesViaXib = true
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Chamar o próximo cartão quando for realizado o gesto swipe
        swipeableView.nextView = {
            return self.proximoCartaoView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define o título da view
        title = "INSIGHT APP"
        
        // Cria o botão bar da esquerda
        let botaoCompartilhar = UIBarButtonItem(image: UIImage(named: "Share-selected.png"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(botaoCompartilharSelecionado))

        // Atribuir os botões criados
        navigationItem.setLeftBarButton(botaoCompartilhar, animated: false)

        // Define a cor da view principal
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        
        swipeableView = ZLSwipeableView()
        view.addSubview(swipeableView)

        swipeableView.didStart = {view, localizacao in
            print("Começou o swipe na posição: \(localizacao)")
        }
        swipeableView.swiping = {view, localizacao, tranducao in
            print("Swipe na localização: \(localizacao) translation: \(tranducao)")
        }
        swipeableView.didEnd = {view, localizacao in
            print("Swipe finalizado na localização: \(localizacao)")
        }
        swipeableView.didSwipe = {view, direcao, vetor in
            print("Swipe indo na direção: \(direcao), vector: \(vetor)")
        }
        swipeableView.didCancel = {view in
            print("Swipe foi cancelado")
        }
        swipeableView.didTap = {view, localizacao in
            print("Toque na localização \(localizacao)")
        }
        swipeableView.didDisappear = { view in
            print("Cartão com frase desapareceu")
        }
        
        constrain(swipeableView, view) { view1, view2 in
            view1.left == view2.left + 50
            view1.right == view2.right - 50
            view1.top == view2.top + 120
            view1.bottom == view2.bottom - 100
        }
    }
    
    // MARK: - Actions
    
    func botaoCompartilharSelecionado() {
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
            
            // Compositor para escrever o compartilhamento
            if let fbComposer = SLComposeViewController(forServiceType: SLServiceTypeFacebook) {
                
                fbComposer.setInitialText("Autor: Kesley Ribeiro") //+ self.nomeAutorLbl.text! + "Kesley Ribeiro" + self.descricaoFraseTxt.text!)
                fbComposer.add(URL(string: "https://www.linkedin.com/in/kesleyribeiro"))
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

    func acaoSwipeDireita() {
        self.swipeableView.swipeTopView(inDirection: .Right)
    }
    
    // MARK: ()
    func proximoCartaoView() -> UIView? {

        func toRadian(_ degree: CGFloat) -> CGFloat {
            return degree * CGFloat(Double.pi/180)
        }

        func rotateAndTranslateView(_ view: UIView, forDegree degree: CGFloat, translation: CGPoint, duration: TimeInterval, offsetFromCenter offset: CGPoint, swipeableView: ZLSwipeableView) {
            
            UIView.animate(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {
                
                view.center = swipeableView.convert(swipeableView.center, from: swipeableView.superview)
                var transformar = CGAffineTransform(translationX: offset.x, y: offset.y)
                transformar = transformar.rotated(by: toRadian(degree))
                transformar = transformar.translatedBy(x: -offset.x, y: -offset.y)
                transformar = transformar.translatedBy(x: translation.x, y: translation.y)
                view.transform = transformar
            }, completion: nil)
        }
        
        swipeableView.numberOfActiveView = 10
        
        swipeableView.animateView = {(view: UIView, index: Int, views: [UIView], swipeableView: ZLSwipeableView) in
            let degree = CGFloat(sin(0.5*Double(index)))
            let offset = CGPoint(x: 0, y: swipeableView.bounds.height*0.3)
            let translation = CGPoint(x: degree*10, y: CGFloat(-index*5))
            let duration = 0.5
            
            rotateAndTranslateView(view, forDegree: degree, translation: translation, duration: duration, offsetFromCenter: offset, swipeableView: swipeableView)
        }
        
        if indiceCores >= cores.count {
            indiceCores = 0
        }

        let cartaoView = CartaoFraseVC(frame: swipeableView.bounds)
        cartaoView.backgroundColor = nomeDaCor(cores[indiceCores])
        indiceCores += 1

        if carregarCartoesViaXib {

            let conteudoView = Bundle.main.loadNibNamed("CartaoFraseView", owner: self, options: nil)?.first! as! UIView
            conteudoView.translatesAutoresizingMaskIntoConstraints = false
            conteudoView.backgroundColor = cartaoView.backgroundColor
            cartaoView.addSubview(conteudoView)
            
            constrain(conteudoView, cartaoView) { view1, view2 in
                view1.left == view2.left
                view1.top == view2.top
                view1.width == cartaoView.bounds.width
                view1.height == cartaoView.bounds.height
            }
        }        
        return cartaoView
    }
    
    func nomeDaCor(_ nome: String) -> UIColor {

        let nomeCor = nome.replacingOccurrences(of: " ", with: "")
        let selecionador = "flat\(nomeCor)Color"
        return UIColor.perform(Selector(selecionador)).takeUnretainedValue() as! UIColor
    }

}
