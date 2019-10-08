//
//  APIForIOSGreater10.m
//  BMCamera
//
//  Created by Steve on 10/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "APIForIOSGreater10.h"

@implementation APIForIOSGreater10

- (void)getDevice {
    self.captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    AVCaptureDeviceDiscoverySession *captureDeviceDiscoverySession = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera]
                                                                                                                            mediaType:AVMediaTypeVideo
                                                                                                                             position:AVCaptureDevicePositionFront];
    NSArray *arrayCaptureDevices = [captureDeviceDiscoverySession devices];
    if (arrayCaptureDevices.count > 0) {
        self.captureDevice = arrayCaptureDevices.firstObject;
        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:&error];
        
        if ([self.captureSession canAddInput:input]) {
            [self.captureSession addInput:input];
        }
        [self.captureSession startRunning];
        return YES;
    }
    return NO;
}
@end
