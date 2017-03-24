//
//  NBToast.swift
//  NBToast
//
//  Created by NapoleonBai on 16/7/8.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

import Foundation
import UIKit


let TOAST_VIEW_MARGIN_BOTTOM : CGFloat = 66.0
let TOAST_VIEW_MARGIN_TOP : CGFloat = 76.0
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
class NBToast : UIView {
    /// 显示文字颜色
    fileprivate static var s_textColor : UIColor             = UIColor.black
    /// 显示文字大小
    fileprivate static var s_textFont : UIFont               = UIFont.systemFont(ofSize: 17)
    /// 显示文字对齐方式
    fileprivate static var s_textAlignment : NSTextAlignment = NSTextAlignment.center
    /// 显示视图背景色
    fileprivate static var s_backgroundColor : UIColor       = UIColor.black.withAlphaComponent(0.5)
    /// 视图最大宽度设置
    fileprivate static var s_maxWidth : CGFloat              = 0.0
    /// 视图最大高度设置
    fileprivate static var s_maxHeight : CGFloat             = 0.0
    /// 文字显示最大行数
    fileprivate static var s_maxLines : UInt16               = 1
    /// 文字边距
    fileprivate static var s_paddingInsets : UIEdgeInsets          = UIEdgeInsets.zero
    /// 视图离顶部距离
    fileprivate static var s_marginTop : CGFloat             = TOAST_VIEW_MARGIN_TOP
    /// 视图离底部距离
    fileprivate static var s_marginBottom : CGFloat          = TOAST_VIEW_MARGIN_BOTTOM
    /// 视图圆角度
    fileprivate static var s_cornerRadius : CGFloat          = 0.0
    /// 视图显示时间
    fileprivate static var s_duration : TimeInterval       = TOAST_VIEW_SHOW_DURATION
    /// 视图在x秒后显示
    fileprivate static var s_delay : TimeInterval          = TOAST_VIEW_SHOW_DELAY
    /**
     设置显示文字颜色<br/>
     <font color='red'>注意:一次设置,全程有效</font>
     - parameter textcolor: color.eg:UIColor.redColor()
     */
    class func setTextColor(_ textcolor:UIColor){
        NBToast.s_textColor = textcolor
    }
    /**
     设置显示文字大小<br/>
     <font color='red'>注意:一次设置,全程有效</font>
     
     - parameter textFont: eg:UIFont.systemFontOfSize(xx)
     */
    class func setTextFont(_ textFont:UIFont){
        NBToast.s_textFont = textFont
    }
    /**
     设置字体对齐方式<br/>
     <font color='red'>注意:一次设置,全程有效</font>

     - parameter alignment: center,left,right
     */
    class func setTextAlignment(_ alignment:NSTextAlignment){
        NBToast.s_textAlignment = alignment
    }
    /**
     设置视图显示背景色
     <br/>
     <font color='red'>注意:一次设置,全程有效</font>
     - parameter backgroundColor:
     */
    class func setBgColor(_ backgroundColor:UIColor){
        NBToast.s_backgroundColor = backgroundColor
    }
    /**
     设置最大宽度
     <br/>
     <font color='red'>注意:一次设置,全程有效</font>
     - parameter maxWidth:
     */
    class func setMaxWidth(_ maxWidth:CGFloat){
        NBToast.s_maxWidth = maxWidth
    }
    /**
     设置视图最大高度
     <br/>
     <font color='red'>注意:一次设置,全程有效</font>
     - parameter maxHeight:
     */
    class func setMaxHeight(_ maxHeight:CGFloat){
        NBToast.s_maxHeight = maxHeight
    }
    /**
     设置文字最大显示多少行
     <br/>
     <font color='red'>注意:一次设置,全程有效</font>
     - parameter maxLines:
     */
    class func setMaxLines(_ maxLines:UInt16){
        NBToast.s_maxLines = maxLines
    }
    /**
     设置文字边距(上,左,下,右)
     <br/>
     <font color='red'>注意:一次设置,全程有效</font>
     - parameter paddingInsets:
     */
    class func setPaddingInsets(_ paddingInsets:UIEdgeInsets){
        NBToast.s_paddingInsets = paddingInsets
    }
    /**
     设置视图到顶部的距离
     <br/>
     <font color='red'>注意:一次设置,全程有效</font>
     
     - parameter marginTop:
     */
    class func setMarginTop(_ marginTop:CGFloat){
        NBToast.s_marginTop = marginTop
    }
    /**
     设置视图到底部的距离
     <br/>
     <font color='red'>注意:一次设置,全程有效</font>
     - parameter marginBottom:
     */
    class func setMarginBottom(_ marginBottom:CGFloat){
        NBToast.s_marginBottom = marginBottom
    }
    /**
     设置视图的圆角度
     <br/>
     <font color='red'>注意:一次设置,全程有效</font>
     - parameter cornerRadius:
     */
    class func setCornerRadius(_ cornerRadius:CGFloat){
        NBToast.s_cornerRadius = cornerRadius
    }
    /**
     设置视图显示时间
     <br/>
     <font color='red'>注意:一次设置,全程有效</font>
     - parameter duration:
     */
    class func setDuration(_ duration:TimeInterval){
        NBToast.s_duration = duration
    }
    /**
     设置等待xx秒才显示
     <br/>
     <font color='red'>注意:一次设置,全程有效</font>
     - parameter delay:
     */
    class func setDelay(_ delay:TimeInterval){
        NBToast.s_delay = delay
    }
    
    /**
     计算最大高度和最大宽度
     */
    class func CalculationMaxWidthAndHeight() {
        if NBToast.s_maxHeight<=0 {
            NBToast.s_maxHeight = portraitScreenWidth() - (NBToast.s_marginTop + NBToast.s_marginBottom)
        }else if NBToast.s_maxHeight > portraitScreenWidth() - (NBToast.s_marginTop + NBToast.s_marginBottom){
            NBToast.s_maxHeight = portraitScreenWidth() - (NBToast.s_marginTop + NBToast.s_marginBottom)
        }
        
        if NBToast.s_maxWidth<=0 {
            NBToast.s_maxWidth = portraitScreenWidth() - 2 * TOAST_VIEW_MAGIN_LEFT_RIGHT
        }
    }
    
}

extension NBToast{    
    /**
     自定义显示时间和延迟显示时间,并手动处理完成事件
     
     - parameter message:   显示文字
     - parameter duration:   显示时间
     - parameter delay:      延迟显示时间
     - parameter completion: 显示完成时回调
     */
    class func show(_ message:NSString , duration:TimeInterval = NBToast.s_duration, delay:TimeInterval = NBToast.s_delay, completion:CompLetion? = nil){
        
        if message.length < 1 {
            return
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((__int64_t)(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            
            let keyWindow : UIWindow = UIApplication.shared.keyWindow!

            keyWindow.viewWithTag(TOAST_VIEW_TAG)?.removeFromSuperview()
            
            keyWindow.endEditing(true)
            
            let toastView : UIView = UIView.init()
            toastView.translatesAutoresizingMaskIntoConstraints = false
            toastView.isUserInteractionEnabled = false
            toastView.backgroundColor = NBToast.s_backgroundColor
            toastView.tag = TOAST_VIEW_TAG
            toastView.clipsToBounds = true
            toastView.alpha = 0.0
            
            let toastLabel : UILabel = UILabel.init()
            toastLabel.translatesAutoresizingMaskIntoConstraints = false
            toastLabel.font = NBToast.s_textFont
            toastLabel.text = message as String;
            toastLabel.textColor = NBToast.s_textColor
            toastLabel.textAlignment = NBToast.s_textAlignment;
            toastLabel.numberOfLines = 0;
            
            self.CalculationMaxWidthAndHeight()
            
            let toastTextHeight = message.size(attributes: [NSFontAttributeName : NBToast.s_textFont]).height + 0.5
            
            if UIEdgeInsetsEqualToEdgeInsets(NBToast.s_paddingInsets, UIEdgeInsets.zero){
                NBToast.s_paddingInsets = UIEdgeInsetsMake(toastTextHeight/2.0, toastTextHeight, toastTextHeight/2.0, toastTextHeight)
            }
            
            if NBToast.s_cornerRadius <= 0.0 || NBToast.s_cornerRadius > toastTextHeight/2.0 {
                toastView.layer.cornerRadius = (toastTextHeight + NBToast.s_paddingInsets.top + NBToast.s_paddingInsets.bottom) / 2.0
            }else{
                toastView.layer.cornerRadius = NBToast.s_cornerRadius
            }
            
            let toastLabelSize : CGSize = toastLabel.sizeThatFits(CGSize(width: NBToast.s_maxWidth-(NBToast.s_paddingInsets.left + NBToast.s_paddingInsets.right), height: NBToast.s_maxHeight - (NBToast.s_paddingInsets.top + NBToast.s_paddingInsets.bottom)))
            
            var toastViewWidth : CGFloat = (toastLabelSize.width + 0.5) + (NBToast.s_paddingInsets.left + NBToast.s_paddingInsets.right);
            
            var toastViewHeight : CGFloat = (toastLabelSize.height + 0.5) + (NBToast.s_paddingInsets.top + NBToast.s_paddingInsets.bottom);

            if toastViewWidth > NBToast.s_maxWidth {
                toastViewWidth = NBToast.s_maxWidth
            }
            
            if NBToast.s_maxLines > 0{
                toastViewHeight = toastViewHeight * CGFloat(NBToast.s_maxLines) + NBToast.s_paddingInsets.top + NBToast.s_paddingInsets.bottom
            }
            
            
            
            if toastViewHeight > NBToast.s_maxHeight {
                toastViewHeight = NBToast.s_maxHeight;
            }
            let viewDicts = ["toastLabel":toastLabel,"toastView":toastView]

            toastView.addSubview(toastLabel)
            keyWindow.addSubview(toastView)
            
            toastView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(\(NBToast.s_paddingInsets.left))-[toastLabel]-(\(NBToast.s_paddingInsets.right))-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewDicts))
            
            toastView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(\(NBToast.s_paddingInsets.top))-[toastLabel]-(\(NBToast.s_paddingInsets.bottom))-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewDicts))

            keyWindow.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[toastView(\(toastViewWidth))]", options: NSLayoutFormatOptions(), metrics: nil, views: viewDicts))

            keyWindow.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=\(NBToast.s_marginTop))-[toastView(<=\(toastViewHeight))]-(\(NBToast.s_marginBottom))-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewDicts))

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
        s_textColor       = .black
        s_textFont        = .systemFont(ofSize: 17)
        s_textAlignment   = .center
        s_backgroundColor = UIColor.black.withAlphaComponent(0.5)
        s_maxWidth        = 0.0
        s_maxHeight       = 0.0
        s_maxLines        = 1
        s_paddingInsets         = UIEdgeInsets.zero
        s_marginTop       = TOAST_VIEW_MARGIN_TOP
        s_marginBottom    = TOAST_VIEW_MARGIN_BOTTOM
        s_cornerRadius    = 0.0
        s_duration        = TOAST_VIEW_SHOW_DURATION
        s_delay           = TOAST_VIEW_SHOW_DELAY
    }
}
