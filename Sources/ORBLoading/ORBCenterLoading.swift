// The Swift Programming Language
// https://docs.swift.org/swift-book


import UIKit

import Lottie
import SnapKit

public protocol ORBCenterLoadingStyle: UIView {
    
    func startLoading(withoutShading: Bool)
    func stopLoading()
    
}

public extension ORBCenterLoadingStyle {
    
    func startLoading(withoutShading: Bool) {
        for subview in subviews {
            if let loadingView = subview as? ORBLoadingView {
                subview.backgroundColor = withoutShading ? .clear : .black.withAlphaComponent(0.55)
                return
            }
        }
        
        let loadingView = ORBLoadingView()
        if withoutShading { loadingView.backgroundColor = .black.withAlphaComponent(0.55) }
        
        addSubview(loadingView)
        
        if let scrollView = self as? UIScrollView {
            loadingView.snp.makeConstraints { $0.edges.equalTo(scrollView.frameLayoutGuide) }
        } else {
            loadingView.snp.makeConstraints { $0.edges.equalToSuperview() }
        }
    }
    
    func stopLoading() {
        subviews.forEach { view in
            if let loadingView = view as? ORBLoadingView { loadingView.removeFromSuperview() }
        }
    }
    
}

fileprivate final class ORBLoadingView: UIView {
    
    let lottie = Lottie.LottieAnimationView(name: "loading2")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        lottie.loopMode = .loop
        lottie.play()
        addSubview(lottie)
        lottie.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(150)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
