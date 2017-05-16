//
//  DataService.swift
//  InsightApp
//
//  Created by Kesley Ribeiro on 16/May/17.
//  Copyright © 2017 Kesley Ribeiro. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {

    static let ds = DataService()

    // Referências BD
    private var _REF_BASE = DB_BASE
    private var _REF_FRASES = DB_BASE.child("frases")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }

    var REF_FRASES: FIRDatabaseReference {
        return _REF_FRASES
    }
}
