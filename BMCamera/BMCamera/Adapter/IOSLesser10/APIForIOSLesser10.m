//
//  APIForIOSLesser10.m
//  BMCamera
//
//  Created by Steve on 10/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "APIForIOSLesser10.h"

@interface APIForIOSLesser10()
@end

@implementation APIForIOSLesser10 


- (AVCaptureSession* )getDevice {
    


   AVCaptureSession* captureSession = [AVCaptureSession new];
    captureSession.sessionPreset = AVCaptureSessionPresetHigh;

  
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];

    if (devices.count > 0) {
        captureDevice = devices[0];

        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:&error];

        if ([captureSession canAddInput:input]) {
            [captureSession addInput:input];
        }

      captureStillImageOutput = [AVCaptureStillImageOutput new];
        NSDictionary *settings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
        [captureStillImageOutput setOutputSettings:settings];
        [captureSession addOutput:captureStillImageOutput];

        return captureSession;
    }

    return nil;
}
@end
