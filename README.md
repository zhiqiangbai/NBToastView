# NBToastView
提示视图
效果图<还有很多设置,可以自行查看>
![tost展示图](https://github.com/NapoleonBaiAndroid/NBToastView/blob/master/NBToastView/test.gif "ToastView展示图")

##NBToastView 配置属性
``` swift
    /// 显示文字颜色
    private static var sTextColor : UIColor             = UIColor.blackColor()
    /// 显示文字大小
    private static var sTextFont : UIFont               = UIFont.systemFontOfSize(17)
    /// 显示文字对齐方式
    private static var sTextAlignment : NSTextAlignment = NSTextAlignment.Center
    /// 显示视图背景色
    private static var sBackgroundColor : UIColor       = UIColor.blackColor().colorWithAlphaComponent(0.5)
    /// 视图最大宽度设置
    private static var sMaxWidth : CGFloat              = 0.0
    /// 视图最大高度设置
    private static var sMaxHeight : CGFloat             = 0.0
    /// 文字显示最大行数
    private static var sMaxLines : UInt16               = 1
    /// 文字边距
    private static var sPadding : UIEdgeInsets          = UIEdgeInsetsZero
    /// 视图离顶部距离
    private static var sOffsetTop : CGFloat             = TOAST_VIEW_OFFSET_TOP
    /// 视图离底部距离
    private static var sOffsetBottom : CGFloat          = TOAST_VIEW_OFFSET_BOTTOM
    /// 视图圆角度
    private static var sCornerRadius : CGFloat          = 0.0
    /// 视图显示时间
    private static var sDuration : NSTimeInterval       = TOAST_VIEW_SHOW_DURATION
    /// 视图在x秒后显示
    private static var sDelay : NSTimeInterval          = TOAST_VIEW_SHOW_DELAY
```
##主要提供的展示函数
```swift
    /**
     自定义显示时间和延迟显示时间,并手动处理完成事件
     
     - parameter toastStr:   显示文字
     - parameter duration:   显示时间
     - parameter delay:      延迟显示时间
     - parameter completion: 显示完成时回调
     */
    class func showToast(toastStr:NSString , duration:NSTimeInterval , delay:NSTimeInterval , completion:CompLetion?)
    
    当然,也提供了例如只修改显示文字,显示时间,延迟显示等单独的函数
```
##其他设置
 因为项目中大都是使用同一个提示背景颜色,文字颜色等配置,所以,可以将所有配置信息全部放入 Appdelegate 文件中,一次配置,终身受用!
 同时也提供了:
 ```swift
     /**
     将所有配置清除,恢复默认设置
     */
    class func restoredConfig()
 ```
 此函数用于清除之前配置的属性,恢复为默认的属性.
