//
//  ViewController.m
//  ZBMCamera
//
//  Created by Steve on 10/7/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "ZBMCamera.h"
#import <AVFoundation/AVFoundation.h>
@interface ZBMCamera () <AVCapturePhotoCaptureDelegate>
@property (strong, nonatomic) AVCaptureSession * captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer * captureVideoPreviewLayer;
@property (nonatomic, strong) AVCaptureDevice * captureDevice;
@property (nonatomic, strong) AVCapturePhotoOutput * capturePhotoOutput;
@property (nonatomic, strong)  AVCapturePhotoSettings * setting;

@end

@implementation ZBMCamera

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCaptureSession];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.captureSession startRunning];
}

	- (BOOL)setupCaptureSession {
    self.captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.captureVideoPreviewLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view.layer addSublayer:self.captureVideoPreviewLayer];
//    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
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
//        [self.capturePhotoOutput capturePhotoWithSettings:self.setting delegate:self];
//
//        [self.captureSession addOutput:self.capturePhotoOutput];
        
        return YES;
    }
    
    return NO;
}

- (AVCapturePhotoOutput *)capturePhotoOutput {
    if (!_capturePhotoOutput) {
        _capturePhotoOutput = AVCapturePhotoOutput.new;
    }
    return _capturePhotoOutput;
}

- (AVCaptureSession *)captureSession {
    if (!_captureSession) {
        _captureSession = AVCaptureSession.new;
    }
    return _captureSession;
}

- (AVCapturePhotoSettings *)setting {
    if (!_setting) {
        _setting = AVCapturePhotoSettings.new;
        _setting = [AVCapturePhotoSettings photoSettingsWithFormat:@{AVVideoCodecKey : AVVideoCodecTypeJPEG}];
    }
    return  _setting;
}
- (AVCaptureVideoPreviewLayer *)captureVideoPreviewLayer {
    if (!_captureVideoPreviewLayer) {
        [self.view.layer addSublayer:_captureVideoPreviewLayer];

        _captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    }
    return _captureVideoPreviewLayer;
}

@end
