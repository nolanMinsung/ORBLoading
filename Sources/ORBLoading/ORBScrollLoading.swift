//
//  File.swift
//  ORBLoading
//
//  Created by 김민성 on 3/28/25.
//

import UIKit

import Lottie
import SnapKit


/// 무한스크롤 시 scroll view 컨텐츠 아래에 로딩 화면을 띄우고자 할 경우, 해당 scroll view에서 이 프로토콜을 채택
public protocol ORBScrollLoadingStyle: UIScrollView {
    
    var scrollLoadingLottieOffset: CGFloat { get }
    var scrollLoadingLottieSideLength: CGFloat { get }
    var additionalContentInset: CGFloat { get }
    
    func startBottomScrollLoading()
    func stopBottomScrollLoading()
    
}

public extension ORBScrollLoadingStyle {
    
    var scrollLoadingLottieOffset: CGFloat { 18 }
    var scrollLoadingLottieSideLength: CGFloat { 38 }
    var additionalContentInset: CGFloat { scrollLoadingLottieSideLength + (scrollLoadingLottieOffset * 2) }
    
    /// scroll view 아래쪽의 무한 스크롤 로딩 화면을 띄웁니다.
    func startBottomScrollLoading() {
        let scrollLoadingView = ORBScrollLoadingView()
        contentInset.bottom += additionalContentInset
        addSubview(scrollLoadingView)
        layoutIfNeeded()
        scrollLoadingView.frame = .init(
            x: bounds.width/2 - scrollLoadingLottieSideLength/2,
            y: contentSize.height + scrollLoadingLottieOffset,
            width: scrollLoadingLottieSideLength,
            height: scrollLoadingLottieSideLength
        )
    }
    
    /// scroll view 컨텐츠 아래쪽에 무한 스크롤 로딩이 있다면 로딩을 멈춥니다.
    func stopBottomScrollLoading() {
        var isScrollLoading: Bool = false
        subviews.forEach { view in
            if let scrollLoadingView = view as? ORBScrollLoadingView {
                scrollLoadingView.removeFromSuperview()
                isScrollLoading = true
            }
        }
        if isScrollLoading {
            contentInset.bottom -= additionalContentInset
        }
    }
    
}

fileprivate final class ORBScrollLoadingView: UIView {
    
    let lottie = Lottie.LottieAnimationView(name: "loading1")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = false
        lottie.loopMode = .loop
        lottie.play()
        addSubview(lottie)
        lottie.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
