//
//  ViewController.h
//  ZBMCamera
//
//  Created by Steve on 10/7/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "../Define.h"
#import "../Adapter/IOSLesser10/APIForIOSLesser10.h"
#import "../Adapter/IOSGreater10/APIForIOSGreater10.h"

@interface  CameraCore: NSObject

//duylh2: dư
@property (strong, nonatomic) AVCaptureSession * captureSession;
@property (nonatomic, strong) AVCaptureDevice * captureDevice;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer * captureVideoPreviewLayer;
@property (nonatomic, strong) AVCapturePhotoOutput * capturePhotoOutput;
@property (nonatomic, strong) AVCapturePhotoSettings * setting;

- (AVCaptureDevice *) getCurrentCaptureDeviceWithPostion:(AVCaptureDevicePosition) position;
@end

