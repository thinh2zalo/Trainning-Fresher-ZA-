//
//  ViewController.m
//  ZBMCamera
//
//  Created by Steve on 10/7/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "CameraCore.h"
#import "../GetAPIProtocol.m"
@interface CameraCore () <AVCapturePhotoCaptureDelegate>
@property (nonatomic, strong) id getVersionIOS ;

@end


@implementation CameraCore


- (AVCaptureDevice *) getCurrentCaptureDeviceWithPostion:(AVCaptureDevicePosition) position{
    if (self.getVersionIOS) {
        return [self.getVersionIOS getCaptureDeviceWithPostion:position];
    }
    return nil;
}

- (id)getVersionIOS {
    if (!_getVersionIOS) {

        if (SYSTEM_VERSION_LESS_THAN(@"10.0")) {
            _getVersionIOS = APIForIOSLesser10.new;
            return _getVersionIOS;
        }
        //duylh2: dư if
        else if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
            _getVersionIOS = APIForIOSGreater10.new;
            return _getVersionIOS;
        }
    }
    return _getVersionIOS;
}

//duylh2: dư
- (AVCaptureVideoPreviewLayer *)captureVideoPreviewLayer {
    if (!_captureVideoPreviewLayer) {
        _captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    }
    return _captureVideoPreviewLayer;
}

@end
