//
//  CTTTransactionApiRequest.swift
//  CTT
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation

public class CTTTransactionApiRequest: BaseTransactionApiRequest {
    
    public override var path: String {
        return "/transactions/genqr"
    }

}
