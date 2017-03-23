//
//  NBToastView.swift
//  NBToastView
//
//  Created by NapoleonBai on 16/7/8.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

import Foundation
import UIKit


let TOAST_VIEW_OFFSET_BOTTOM : CGFloat = 66.0
let TOAST_VIEW_OFFSET_TOP : CGFloat = 76.0
let TOAST_VIEW_SHOW_DELAY : TimeInterval = 0.0
let TOAST_VIEW_SHOW_DURATION : TimeInterval = 1.0
let TOAST_VIEW_TAG : NSInteger = 8888
let TOAST_VIEW_MAGIN_LEFT_RIGHT : CGFloat = 20.0

/// 显示完成时执行
typealias CompLetion = (() ->Void)

func portraitScreenWidth() -> CGFloat {
    return UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation) ? UIScreen.main.bounds.width : UIScreen.main.bounds.height
}

func portraitScreenHeight() -> CGFloat {
    return UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation) ? UIScreen.main.bounds.height : UIScreen.main.bounds.width
}


/**
 * 展示Toast提示视图,提供文字颜色,内边距,背景色,字体等设置
 */
class NBToastView : UIView {
    /// 显示文字颜色
    fileprivate static var sTextColor : UIColor             = UIColor.black
    /// 显示文字大小
    fileprivate static var sTextFont : UIFont               = UIFont.systemFont(ofSize: 17)
    /// 显示文字对齐方式
    fileprivate static var sTextAlignment : NSTextAlignment = NSTextAlignment.center
    /// 显示视图背景色
    fileprivate static var sBackgroundColor : UIColor       = UIColor.black.withAlphaComponent(0.5)
    /// 视图最大宽度设置
    fileprivate static var sMaxWidth : CGFloat              = 0.0
    /// 视图最大高度设置
    fileprivate static var sMaxHeight : CGFloat             = 0.0
    /// 文字显示最大行数
    fileprivate static var sMaxLines : UInt16               = 1
    /// 文字边距
    fileprivate static var sPadding : UIEdgeInsets          = UIEdgeInsets.zero
    /// 视图离顶部距离
    fileprivate static var sOffsetTop : CGFloat             = TOAST_VIEW_OFFSET_TOP
    /// 视图离底部距离
    fileprivate static var sOffsetBottom : CGFloat          = TOAST_VIEW_OFFSET_BOTTOM
    /// 视图圆角度
    fileprivate static var sCornerRadius : CGFloat          = 0.0
    /// 视图显示时间
    fileprivate static var sDuration : TimeInterval       = TOAST_VIEW_SHOW_DURATION
    /// 视图在x秒后显示
    fileprivate static var sDelay : TimeInterval          = TOAST_VIEW_SHOW_DELAY
    /**
     设置显示文字颜色<br/>
     <font color='red'>注意:一次设置,全程有效</font>
     - parameter textcolor: color.eg:UIColor.redColor()
     */
    class func setTextColor(_ textcolor:UIColor){
        NBToastView.sTextColor = textcolor
    }
    /**
     设置显示文字大小<br/>
     <font color='red'>注意:一次设置,全程有效</font>
     
     - parameter textFont: eg:UIFont.systemFontOfSize(xx)
     */
    class func setTextFont(_ textFont:UIFont){
        NBToastView.sTextFont = textFont
    }
    /**
     设置字体对齐方式<br/>
     <font color='red'>注意:一次设置,全程有效</font>

     - parameter alignment: center,left,right
     */
    class func setTextAlignment(_ alignment:NSTextAlignment){
        NBToastView.sTextAlignment = alignment
    }
    /**
     设置视图显示背景色
     <br/>
     <font color='red'>注意:一次设置,全程有效</font>
     - parameter backgroundColor:
     */
    class func setBgColor(_ backgroundColor:UIColor){
        NBToastView.sBackgroundColor = backgroundColor
    }
    /**
     设置最大宽度
     <br/>
     <font color='red'>注意:一次设置,全程有效</font>
     - parameter maxWidth:
     */
    class func setMaxWidth(_ maxWidth:CGFloat){
        NBToastView.sMaxWidth = maxWidth
    }
    /**
     设置视图最大高度
     <br/>
     <font color='red'>注意:一次设置,全程有效</font>
     - parameter maxHeight:
     */
    class func setMaxHeight(_ maxHeight:CGFloat){
        NBToastView.sMaxHeight = maxHeight
    }
    /**
     设置文字最大显示多少行
     <br/>
     <font color='red'>注意:一次设置,全程有效</font>
     - parameter maxLines:
     */
    class func setMaxLines(_ maxLines:UInt16){
        NBToastView.sMaxLines = maxLines
    }
    /**
     设置文字边距(上,左,下,右)
     <br/>
     <font color='red'>注意:一次设置,全程有效</font>
     - parameter padding:
     */
    class func setPadding(_ padding:UIEdgeInsets){
        NBToastView.sPadding = padding
    }
    /**
     设置视图到顶部的距离
     <br/>
     <font color='red'>注意:一次设置,全程有效</font>
     
     - parameter offSetTop:
     */
    class func setOffSetTop(_ offSetTop:CGFloat){
        NBToastView.sOffsetTop = offSetTop
    }
    /**
     设置视图到底部的距离
     <br/>
     <font color='red'>注意:一次设置,全程有效</font>
     - parameter offSetBottom:
     */
    class func setOffSetBottom(_ offSetBottom:CGFloat){
        NBToastView.sOffsetBottom = offSetBottom
    }
    /**
     设置视图的圆角度
     <br/>
     <font color='red'>注意:一次设置,全程有效</font>
     - parameter cornerRadius:
     */
    class func setCornerRadius(_ cornerRadius:CGFloat){
        NBToastView.sCornerRadius = cornerRadius
    }
    /**
     设置视图显示时间
     <br/>
     <font color='red'>注意:一次设置,全程有效</font>
     - parameter duration:
     */
    class func setDuration(_ duration:TimeInterval){
        NBToastView.sDuration = duration
    }
    /**
     设置等待xx秒才显示
     <br/>
     <font color='red'>注意:一次设置,全程有效</font>
     - parameter delay:
     */
    class func setDelay(_ delay:TimeInterval){
        NBToastView.sDelay = delay
    }
    
    /**
     计算最大高度和最大宽度
     */
    class func CalculationMaxWidthAndHeight() {
        if NBToastView.sMaxHeight<=0 {
            NBToastView.sMaxHeight = portraitScreenWidth() - (NBToastView.sOffsetTop + NBToastView.sOffsetBottom)
        }else if NBToastView.sMaxHeight > portraitScreenWidth() - (NBToastView.sOffsetTop + NBToastView.sOffsetBottom){
            NBToastView.sMaxHeight = portraitScreenWidth() - (NBToastView.sOffsetTop + NBToastView.sOffsetBottom)
        }
        
        if NBToastView.sMaxWidth<=0 {
            NBToastView.sMaxWidth = portraitScreenWidth() - 2 * TOAST_VIEW_MAGIN_LEFT_RIGHT
        }
    }
    
}

extension NBToastView{
    /**
     显示提示视图,默认设置
     
     - parameter toastStr:提示文字
     */
    class func showToast(_ toastStr:NSString){
        self.showToast(toastStr, duration: NBToastView.sDuration, delay: NBToastView.sDelay, completion: nil)
    }

    /**
     自定义显示时间
     
     - parameter toastStr: 提示文字
     - parameter duration: 显示时间
     */
    class func showToast(_ toastStr:NSString , duration:TimeInterval){
        self.showToast(toastStr, duration: duration, delay: NBToastView.sDelay, completion: nil)
    }
    /**
     自定义延迟显示时间
     
     - parameter toastStr: 提示文字
     - parameter delay:    延迟时间
     */
    class func showToast(_ toastStr:NSString , delay:TimeInterval){
        self.showToast(toastStr, duration: NBToastView.sDuration, delay:delay, completion: nil)
    }
    
    /**
     自定义显示时间和延迟显示时间
     
     - parameter toastStr: 提示文字
     - parameter duration: 显示时间
     - parameter delay:    延迟显示时间
     */
    class func showToast(_ toastStr:NSString , duration:TimeInterval , delay:TimeInterval){
        self.showToast(toastStr, duration: duration, delay: delay, completion: nil)
    }
    /**
     处理显示完毕事件
     
     - parameter toastStr:   提示文字
     - parameter completion: 显示完成时回调
     */
    class func showToast(_ toastStr:NSString , completion:CompLetion?){
        self.showToast(toastStr, duration: NBToastView.sDuration, delay: NBToastView.sDelay, completion: completion)
    }
    
    /**
     自定义显示时间,并手动处理完成时事件
     
     - parameter toastStr:   提示文字
     - parameter duration:   显示时间
     - parameter completion: 显示完成时回调
     */
    class func showToast(_ toastStr:NSString , duration:TimeInterval , completion:CompLetion?){
        self.showToast(toastStr, duration: duration, delay: NBToastView.sDelay, completion: completion)
    }
    
    /**
     自定义延迟显示时间,并手动处理完成事件
     
     - parameter toastStr:   提示文字
     - parameter delay:      延迟显示时间
     - parameter completion: 显示完成时回调
     */
    class func showToast(_ toastStr:NSString , delay:TimeInterval , completion:CompLetion?){
        self.showToast(toastStr, duration: NBToastView.sDuration, delay: delay, completion: completion)
    }
    
    /**
     自定义显示时间和延迟显示时间,并手动处理完成事件
     
     - parameter toastStr:   显示文字
     - parameter duration:   显示时间
     - parameter delay:      延迟显示时间
     - parameter completion: 显示完成时回调
     */
    class func showToast(_ toastStr:NSString , duration:TimeInterval , delay:TimeInterval , completion:CompLetion?){
        
        if toastStr.length < 1 {
            return
        }

        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((__int64_t)(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            
            let keyWindow : UIWindow = UIApplication.shared.keyWindow!

            keyWindow.viewWithTag(TOAST_VIEW_TAG)?.removeFromSuperview()
            
            keyWindow.endEditing(true)
            
            let toastView : UIView = UIView.init()
            toastView.translatesAutoresizingMaskIntoConstraints = false
            toastView.isUserInteractionEnabled = false
            toastView.backgroundColor = NBToastView.sBackgroundColor
            toastView.tag = TOAST_VIEW_TAG
            toastView.clipsToBounds = true
            toastView.alpha = 0.0
            
            let toastLabel : UILabel = UILabel.init()
            toastLabel.translatesAutoresizingMaskIntoConstraints = false
            toastLabel.font = NBToastView.sTextFont
            toastLabel.text = toastStr as String;
            toastLabel.textColor = NBToastView.sTextColor
            toastLabel.textAlignment = NBToastView.sTextAlignment;
            toastLabel.numberOfLines = 0;
            
            self.CalculationMaxWidthAndHeight()
            
            let toastTextHeight = toastStr.size(attributes: [NSFontAttributeName : NBToastView.sTextFont]).height + 0.5
            
            if UIEdgeInsetsEqualToEdgeInsets(NBToastView.sPadding, UIEdgeInsets.zero){
                NBToastView.sPadding = UIEdgeInsetsMake(toastTextHeight/2.0, toastTextHeight, toastTextHeight/2.0, toastTextHeight)
            }
            
            if NBToastView.sCornerRadius <= 0.0 || NBToastView.sCornerRadius > toastTextHeight/2.0 {
                toastView.layer.cornerRadius = (toastTextHeight + NBToastView.sPadding.top + NBToastView.sPadding.bottom) / 2.0
            }else{
                toastView.layer.cornerRadius = NBToastView.sCornerRadius
            }
            
            let toastLabelSize : CGSize = toastLabel.sizeThatFits(CGSize(width: NBToastView.sMaxWidth-(NBToastView.sPadding.left + NBToastView.sPadding.right), height: NBToastView.sMaxHeight - (NBToastView.sPadding.top + NBToastView.sPadding.bottom)))
            
            var toastViewWidth : CGFloat = (toastLabelSize.width + 0.5) + (NBToastView.sPadding.left + NBToastView.sPadding.right);
            
            var toastViewHeight : CGFloat = (toastLabelSize.height + 0.5) + (NBToastView.sPadding.top + NBToastView.sPadding.bottom);

            if toastViewWidth > NBToastView.sMaxWidth {
                toastViewWidth = NBToastView.sMaxWidth
            }
            
            if NBToastView.sMaxLines > 0{
                toastViewHeight = toastViewHeight * CGFloat(NBToastView.sMaxLines) + NBToastView.sPadding.top + NBToastView.sPadding.bottom
            }
            
            if toastViewHeight > NBToastView.sMaxHeight {
                toastViewHeight = NBToastView.sMaxHeight;
            }
            
            let viewDicts = ["toastLabel":toastLabel,"toastView":toastView]

            toastView.addSubview(toastLabel)
            keyWindow.addSubview(toastView)
            
            toastView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(\(NBToastView.sPadding.left))-[toastLabel]-(\(NBToastView.sPadding.right))-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewDicts))
            
            toastView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(\(NBToastView.sPadding.top))-[toastLabel]-(\(NBToastView.sPadding.bottom))-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewDicts))

            keyWindow.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[toastView(\(toastViewWidth))]", options: NSLayoutFormatOptions(), metrics: nil, views: viewDicts))

            keyWindow.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=\(NBToastView.sOffsetTop))-[toastView(<=\(toastViewHeight))]-(\(NBToastView.sOffsetBottom))-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewDicts))

            keyWindow.addConstraint(NSLayoutConstraint.init(item: toastView, attribute:.centerX, relatedBy: .equal, toItem: keyWindow, attribute: .centerX, multiplier: 1.0, constant: 0.0))
            
            keyWindow.layoutIfNeeded()
            
            UIView.animate(withDuration: TOAST_VIEW_SHOW_DURATION, animations: { 
                toastView.alpha = 1.0
            })
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((__int64_t)(duration * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
                UIView.animate(withDuration: TOAST_VIEW_SHOW_DURATION, animations: { 
                    toastView.alpha = 0.0
                    }, completion: { (finish:Bool) in
                        if finish {
                            toastView.removeFromSuperview()
                            if completion != nil{
                                completion!()
                            }
                        }
                })
            }

        }
    }
    /**
     将所有配置清除,恢复默认设置
     */
    class func restoredConfig() {
        sTextColor       = .black
        sTextFont        = .systemFont(ofSize: 17)
        sTextAlignment   = .center
        sBackgroundColor = UIColor.black.withAlphaComponent(0.5)
        sMaxWidth        = 0.0
        sMaxHeight       = 0.0
        sMaxLines        = 1
        sPadding         = UIEdgeInsets.zero
        sOffsetTop       = TOAST_VIEW_OFFSET_TOP
        sOffsetBottom    = TOAST_VIEW_OFFSET_BOTTOM
        sCornerRadius    = 0.0
        sDuration        = TOAST_VIEW_SHOW_DURATION
        sDelay           = TOAST_VIEW_SHOW_DELAY
    }
}
