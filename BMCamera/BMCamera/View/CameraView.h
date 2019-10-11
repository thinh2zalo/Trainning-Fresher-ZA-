//
//  CameraView.h
//  ZBMCamera
//
//  Created by Steve on 10/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../CameraCore/CameraCore.h"
#import "../CameraEnum/CameraEnum.h"

NS_ASSUME_NONNULL_BEGIN

//duylh2: Handle thêm CameraConfig -> lưu xuống local

@interface CameraView : UIView

//duylh2: private
@property (nonatomic, strong) CameraCore * cameraCore;
@property (strong, nonatomic) AVCaptureSession * captureSession;
@property (nonatomic, strong) AVCaptureDevice * captureDevice;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer * captureVideoPreviewLayer;

- (void) startCameraWithPosition:(AVCaptureDevicePosition) position;

//duylh2: đổi sang property
- (void) changeCameraPosition :(AVCaptureDevicePosition) position ;
- (AVCaptureDevicePosition )getCurrentPosition;

@end

NS_ASSUME_NONNULL_END
