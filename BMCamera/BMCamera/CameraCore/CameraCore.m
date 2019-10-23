//
//  ViewController.m
//  ZBMCamera
//
//  Created by Steve on 10/7/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "CameraCore.h"
#import "../CameraEnum/CameraEnum.h"
//#import "../View/CameraView+Execute.h"
@interface CameraCore () <AVCapturePhotoCaptureDelegate>
@property (nonatomic, strong) id getVersionIOS ;

@end


@implementation CameraCore


- (AVCaptureDevice *) getCurrentCaptureDeviceWithPostion:(BMCamPosition) position{
    if (self.getVersionIOS) {
        return [self.getVersionIOS getCaptureDeviceWithPostion:position];
    }
    return nil;
}

- (AVCaptureOutput *) getCaptureOutput:(struct photoCaptureOptions)options {
    if (self.getVersionIOS) {
        return [self.getVersionIOS getCaptureOutput:options];
    }
    return nil;
}

- (id)getVersionIOS {
    if (!_getVersionIOS) {

        if (SYSTEM_VERSION_LESS_THAN(@"10.0")) {
            _getVersionIOS = APIForIOSLesser10.new;
            return _getVersionIOS;
        }
        else     _getVersionIOS = APIForIOSGreater10.new;
            return _getVersionIOS;
        }
    
    return _getVersionIOS;
}



@end
