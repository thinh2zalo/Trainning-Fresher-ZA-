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
@property (nonatomic, strong) id getAPI;

@end


@implementation CameraCore


- (BOOL)setupCaptureSession {
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

- (void) getDevice {
    [self.getAPI getDevice];
}

- (id)getAPI {
    if (!_getAPI) {
        if (SYSTEM_VERSION_LESS_THAN(@"10.0")) {
            _getAPI = APIForIOSLesser10.new;
            return _getAPI;
        }
        
        else if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
            _getAPI = APIForIOSGreater10.new;
            return _getAPI;
        }
    }
    return _getAPI;
}

- (AVCaptureSession *)captureSession {
    if (!_captureSession) {
        _captureSession = AVCaptureSession.new;
    }
    return _captureSession;
}

- (AVCaptureVideoPreviewLayer *)captureVideoPreviewLayer {
    if (!_captureVideoPreviewLayer) {
        _captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    }
    return _captureVideoPreviewLayer;
}

@end
