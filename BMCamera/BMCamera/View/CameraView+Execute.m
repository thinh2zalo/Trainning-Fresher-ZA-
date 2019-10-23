//
//  CameraView+Execute.m
//  BMCamera
//
//  Created by Steve on 10/22/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "CameraView+Execute.h"
#import "../Utilities/CapturePhotoOptions.h"

@implementation CameraView (Execute)

- (void)takePicture {
    struct photoCaptureOptions options;
    options.camPos = kBMCamPositionBack;
    options.imageQulity = 90;
    options.interfaceOrientation = UIInterfaceOrientationPortrait;
    options.origin = CGPointZero;
    options.ratio = kBMTHREE_FOUR;
    self.captureOutput = [self.cameraCore getCaptureOutput:options];

}




@end
