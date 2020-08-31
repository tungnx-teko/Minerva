//
//  BaseTransactionApiRequest.swift
//  Core
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation
import TekCoreNetwork

public struct AnyRequest: BaseRequestProtocol {
    public typealias ResponseType = BaseTransactionResponse
    
    private let box: AnyRequestBox
    
    public init<Base>(_ base: Base) where Base: BaseRequestProtocol {
        if let anyService = base as? AnyRequest {
            self = anyService
        } else {
            self.box = Box(base: base)
        }
    }
    
    var base: Any { box.base }
    public var encoder: APIParamEncoder { box.encoder }
    public var method: APIMethod { box.method }
    public var path: String { box.path }
    public var hasToken: Bool { box.hasToken }
}

private protocol AnyRequestBox {
    var base: Any { get }
    
    var encoder: APIParamEncoder { get }
    var method: APIMethod { get }
    var path: String { get }
    var hasToken: Bool { get }
}

private struct Box<Base>: AnyRequestBox where Base: BaseRequestProtocol {
    let _base: Base
    
    init(base: Base) {
        self._base = base
    }
    
    var base: Any { _base }
    var encoder: APIParamEncoder { _base.encoder }
    var method: APIMethod { _base.method }
    var path: String { _base.path }
    var hasToken: Bool { _base.hasToken }
    
}
