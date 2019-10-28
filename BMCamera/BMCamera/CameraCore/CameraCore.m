//
//  ViewController.m
//  ZBMCamera
//
//  Created by Steve on 10/7/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "CameraCore.h"
#import "../CameraEnum/CameraEnum.h"
#import <CoreMotion/CoreMotion.h>


@interface CameraCore () <AVCapturePhotoCaptureDelegate>
@property (strong, nonatomic) CMMotionManager * motionManager;
@property (nonatomic, strong) id getVersionIOS ;

@end


@implementation CameraCore

- (instancetype)init
{
    self = [super init];
    if (self) {
        CameraCore __weak * weakSelf = self;
        self.motionManager = [[CMMotionManager alloc] init];
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue new]
                                                 withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                     if (!error) {
                                                         self.orientation = [weakSelf getOrientationBy:accelerometerData.acceleration];
                                                     } else {
                                                         // handle error
                                                     }
                                                 }];
        
         }
         return self;

}

- (UIInterfaceOrientation)getOrientationBy:(CMAcceleration)acceleration {
    UIInterfaceOrientation newOrientation;
    NSLog(@"Y: %f and X  : %f", ABS( acceleration.y ), ABS( acceleration.x ));
    newOrientation =  ABS( acceleration.y ) < ABS( acceleration.x )
    ?   acceleration.x > 0 ? UIInterfaceOrientationLandscapeLeft  :  UIInterfaceOrientationLandscapeRight
    :   acceleration.y > 0 ? UIInterfaceOrientationPortraitUpsideDown : UIInterfaceOrientationPortrait;
    if (newOrientation != self.orientation) {
        self.orientation = newOrientation;
    }
    return newOrientation;
    
}


- (AVCaptureDevice *) getCurrentCaptureDeviceWithPostion:(BMCamPosition) position{
    if (self.getVersionIOS) {
        return [self.getVersionIOS getCaptureDeviceWithPostion:position];
        
    }
    return nil;
}

- (void)capturePhoto:(AVCaptureOutput *) photoOutput options:(struct photoCaptureOptions) options handle:(handlerAfterCapture) handlerAfterCapture{
    if (photoOutput) {
        [self.getVersionIOS capturePhoto:photoOutput photoCaptureOptions:options handlerAfterCapture:handlerAfterCapture];
    }
}

- (AVCaptureOutput *) getCaptureOutput:(BMTypeCamera)type {
    switch (type) {
        case kBMPhoto:  if (self.getVersionIOS) {
            return [self.getVersionIOS getCaptureOutput];
        }
        default: return AVCaptureVideoDataOutput.new;
    }
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

