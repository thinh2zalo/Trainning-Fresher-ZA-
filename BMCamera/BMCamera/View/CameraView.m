//
//  CameraView.m
//  ZBMCamera
//
//  Created by Steve on 10/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "CameraView.h"

@interface CameraView()
@property (nonatomic, assign) AVCaptureDevicePosition position;
@property (nonatomic, strong) AVCaptureDeviceType deviceType;
@property (nonatomic) CameraRatio cameraRatio;

@end

@implementation CameraView

- (void)layoutSubviews {
    [super layoutSubviews];
    self.captureVideoPreviewLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void) stopCamera {
    
}

- (void) startCameraWithPosition:(AVCaptureDevicePosition) position{
    //duylh2: dùng CameraConfig để lưu xuống local
    self.position = position;
//    self.deviceType = type;
    if (!_captureSession) {
        [self setupSession];
    } else {
        if (![self.captureSession isRunning]) {
            [self.captureSession startRunning];
        }
    }
}

//duylh2: setupSession đang làm nhiều mục đích hơn tên hàm của nó
- (void)setupSession {
    //duylh2: tại sao có code chỗ này
    self.captureSession;
    CameraView * __weak weakSelf = self;
    if (weakSelf) {
        //duylh2: lưu một property dispatch_queue
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            CameraView * strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf.captureSession beginConfiguration];
                [strongSelf changeCameraPosition:strongSelf.position];
                [strongSelf.captureSession commitConfiguration];
            } else {
                NSLog(@"self has been deallocated in the meantime.");
            }
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [strongSelf.captureSession startRunning];
            });
        });
    }
}

- (void)updateRatio:(CameraRatio) ratio {
    
}


- (AVCaptureDevicePosition )getCurrentPosition {
    return [self.captureDevice position];
}
//duylh2: dispatch_queue
- (void)changeCameraPosition :(AVCaptureDevicePosition) position {
    if (_captureSession) {
        NSError *error = nil;
         
        [self.captureSession beginConfiguration];
        
        for (AVCaptureInput * input in [self.captureSession inputs]) {
            if ([input isKindOfClass:AVCaptureDeviceInput.class] && [[(AVCaptureDeviceInput * )input device] position] != position) {
                [self.captureSession removeInput:input];
            }
        }
        
        //duylh2: while set sessionPreset -> should we check canSetSessionPreset -> why???
        self.captureSession.sessionPreset = AVCaptureSessionPresetHigh;
        self.captureDevice = [self.cameraCore getCurrentCaptureDeviceWithPostion:position];
        
        //handle Error?
        AVCaptureDeviceInput *newDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:&error];
        
        //Why check canAddInput?
        // can not add multi the same input.
        if ([self.captureSession canAddInput:newDeviceInput]) {
            [self.captureSession addInput:newDeviceInput];
            [self.captureSession addInput:newDeviceInput];
            [self.captureSession addInput:newDeviceInput];
        }
      [self.captureSession commitConfiguration];
    }
}

- (AVCaptureVideoPreviewLayer *)captureVideoPreviewLayer {
    if (!_captureVideoPreviewLayer) {
        _captureVideoPreviewLayer = AVCaptureVideoPreviewLayer.new;
        _captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
        _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.layer addSublayer:_captureVideoPreviewLayer];
    }
    return _captureVideoPreviewLayer;
}



- (AVCaptureSession *)captureSession {
    if (!_captureSession) {
        
        _captureSession = AVCaptureSession.new;
        
    }
    return _captureSession;
}


- (CameraCore *)cameraCore {
    if (!_cameraCore) {
        _cameraCore = CameraCore.new;
    }
    return _cameraCore;
}
- (void)takePhoto {
    
}


@end
