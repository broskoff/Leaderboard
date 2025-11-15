import Foundation

protocol IFlowController {
    
    associatedtype T
    var completionHandler: ((T) -> ())? { get set }
}
