# opencv-ORB-in-Swift

First step:build a camera:

Implement in viewcontroller/previewviewcontroller

see more detail in youtube:
Swift 4 - Get Started with iOS 11: Build A Beautiful Custom Camera using Xcode 9


Second step:use the photo

Since swift can't use opencv directly, we have to build a bridgeheader. Also we have to change the UIImage format into Mat to make it usable in opencv. Implement in opencvwrapper.h/opencvwrapper.mm.

see more detail in youtube:
OpenCV 3 with Swift
