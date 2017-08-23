# ControllerTransition
仿网易的控制器转场动画

使用NavigationController驱动
很简单很单纯的小文件，直接下载导入即可
### 使用方法：
```swift
interactiveTransition = InteractivityTransition.init(gestureType: .pan, controlAnimationType: .Slider, viewController: self)
//如果你需要右滑push新controller的话
//interactiveTransition?.pushViewController = newController
self.setKj_RightGesture(kj_rightGesture: false)
```

最后在 viewWillLoad中添加
```swift
self.navigationController?.delegate = interactiveTransition
```
