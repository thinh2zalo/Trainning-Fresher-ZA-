//
//  GetAPIProtocal.m
//  BMCamera
//
//  Created by Steve on 10/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "../CameraEnum/CameraEnum.h"
#import "../CameraCore/PhotoCaptureProcessor.h"
#import "../CameraCore/CameraViewDelegate.h"
//#import "View/CameraView+Execute.h"
#ifndef DecodeProtocol_h
#define DecodeProtocol_h

@protocol GetAPIProtocol <NSObject>
typedef void(^handlerAfterCapture)(UIImage * image);
//@property (nonatomic, strong)
- (AVCaptureDevice *) getCaptureDeviceWithPostion:(BMCamPosition) position;
- (AVCaptureOutput *) getCaptureOutput;
- (void)capturePhoto:(AVCaptureOutput *) capturePhotoOutput photoCaptureOptions:(struct photoCaptureOptions) options handlerAfterCapture:(handlerAfterCapture) handlerAfterCapture ;

@end

#endif /* DecodeProtocol_h */

