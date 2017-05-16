//
//  Frase.swift
//  InsightApp
//
//  Created by Kesley Ribeiro on 16/May/17.
//  Copyright © 2017 Kesley Ribeiro. All rights reserved.
//

import Foundation
import Firebase

class Frase {

    private var _autor: String!
    private var _descricao: String!
    private var _fraseKey: String!
    private var _fraseRef: FIRDatabaseReference!

    var autor: String {
        return _autor
    }

    var descricao: String {
        return _descricao
    }

    var fraseKey: String {
        return _fraseKey
    }
    
    init(autor: String, descricao: String) {
        self._autor = autor
        self._descricao = descricao
    }
    
    init(fraseKey: String, fraseData: Dictionary<String, AnyObject>) {
        
        self._fraseKey = fraseKey

        if let autor = fraseData["autor"] as? String {
            self._autor = autor
        }
        
        if let descricao = fraseData["descricao"] as? String {
            self._descricao = descricao
        }

        _fraseRef = DataService.ds.REF_FRASES.child(_fraseKey)
    }
}
