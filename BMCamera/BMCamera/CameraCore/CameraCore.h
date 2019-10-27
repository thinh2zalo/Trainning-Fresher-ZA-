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
#import "PhotoCaptureProcessor.h"

@interface  CameraCore: NSObject

- (AVCaptureDevice *) getCurrentCaptureDeviceWithPostion:(BMCamPosition) position;
- (AVCaptureOutput *) getCaptureOutput:(BMTypeCamera)type;
- (void)capturePhoto:(AVCaptureOutput *) photoOutput options:(struct photoCaptureOptions) options;

@property (nonatomic) dispatch_queue_t queue;


@end

