import Foundation

protocol IFlowController {
    
    var completionHandler: ((Int) -> ())? { get set }
}
