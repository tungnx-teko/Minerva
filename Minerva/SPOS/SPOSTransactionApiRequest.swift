//
//  SPOSTransactionApiRequest.swift
//  Spos
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation

public class SPOSTransactionApiRequest: BaseTransactionApiRequest {
    
    public override var path: String {
        return "/transactions/spos"
    }
    
}
