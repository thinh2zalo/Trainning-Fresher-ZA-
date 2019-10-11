//
//  CameraView.m
//  ZBMCamera
//
//  Created by Steve on 10/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "CameraView.h"

@interface CameraView()

@property (nonatomic, strong) CameraCore * cameraCore;
@property (strong, nonatomic) AVCaptureSession * captureSession;
@property (nonatomic, strong) AVCaptureDevice * captureDevice;
@property (nonatomic, weak) AVCaptureVideoPreviewLayer * captureVideoPreviewLayer;

@property (nonatomic, strong) AVCaptureDeviceType deviceType;
@property (nonatomic) dispatch_queue_t queue;

typedef void(^BlockOfBackground)(CameraView * cameraView);
typedef void(^BlockOfMain)(CameraView * cameraView);


@end

//duylh2: atomic cho config
//cap nhat layer.frame khi setFrame cho view
//Handle error cho moi truong hop

@implementation CameraView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void) stopCamera {
    [self async:^(CameraView *cameraView) {
        [self.captureSession stopRunning];
    }];
}


- (void) startCameraWithPosition:(BMPosCam) position{
    //duylh2: dùng CameraConfig để lưu xuống local
    self.position = position;
    //    self.deviceType = type;
    if (!_captureSession) {
        [self setupAndStartSession];
    } else {
        [self async:^(CameraView *cameraView) {
            if (![self.captureSession isRunning]) {
                [self.captureSession startRunning];
            }
        }];
    }
}

- (void)setupAndStartSession {
    self.captureSession = AVCaptureSession.new;
    [self asyncBackground:^(CameraView * cameraView){
        [cameraView.captureSession beginConfiguration];
        BMFlashCamera on = kBMFlashOn;
        
        [cameraView updateFlash:on];
        [cameraView changeCameraPosition:cameraView.position];
        [cameraView.captureSession commitConfiguration];
        [cameraView.captureSession startRunning];
    } asyncMain:^(CameraView * cameraView) {
        BMCameraRatio ratio = kBMSQUARE;
        [cameraView updateRatio:ratio];
    }];
}

- (void)setFlash:(BMFlashCamera)flash {
    if (flash != _flash) {
        [self async:^(CameraView * cameraView) {
            [cameraView updateFlash:flash];
        }];
    }
}

- (void)setRatio:(BMCameraRatio)ratio {
    if (ratio != _ratio) {
        [self updateRatio:ratio];
    }
}

- (void)setPosition:(BMPosCam)position {
    if (position != _position) {
        
        [self async:^(CameraView * camera){
            
            [camera changeCameraPosition:position];
        }];
    }
}

- (AVCaptureDevicePosition )getCurrentPosition {
    return [self.captureDevice position];
}
//duylh2: dispatch_queue
- (void)changeCameraPosition :(BMPosCam) position {
    if (_captureSession) {
        
        [self.captureSession beginConfiguration];
        
        for (AVCaptureInput * input in [self.captureSession inputs]) {
            if ([input isKindOfClass:AVCaptureDeviceInput.class] && [[(AVCaptureDeviceInput * )input device] position] != (AVCaptureDevicePosition) position) {
                [self.captureSession removeInput:input];
            }
        }
        
        if ([self.captureSession canSetSessionPreset:AVCaptureSessionPresetHigh]) {
            self.captureSession.sessionPreset = AVCaptureSessionPresetHigh;
        }
        self.captureDevice = [self.cameraCore getCurrentCaptureDeviceWithPostion:position];
        
        //handle Error?
        AVCaptureDeviceInput *newDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:nil];
        
        if ([self.captureSession canAddInput:newDeviceInput]) {
            [self.captureSession addInput:newDeviceInput];
            
        }
        _position = position;
        [self.captureSession commitConfiguration];
    }
}

- (void)updateRatio:(BMCameraRatio) ratio {
    if (_captureSession) {
        if (!_captureVideoPreviewLayer) {
            _captureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
            _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            [self.layer addSublayer:_captureVideoPreviewLayer];
            [self  updateFrameRatio:ratio];
            
        } else {
            [self  updateFrameRatio:ratio];
        }
        
    } else NSLog(@"error");
}

//duylh2: Cap nhat lai co che layout vi tri
- (void)updateFrameRatio:(BMCameraRatio) ratio {
    CGRect bound = self.layer.bounds;
    float width = bound.size.width;
    CGRect frame = bound;
    switch (ratio) {
        case kBMSQUARE: frame = CGRectMake(0, 70, width, width);  NSLog(@"square");
            break;
        case kBMTHREE_FOUR: frame = CGRectMake(0, 0, width, (width / 3 )* 4); break;
        case kBMFULL: frame = bound; NSLog(@"full");
    }
    _ratio = ratio;
    _captureVideoPreviewLayer.frame = frame;
}

- (void)updateFlash:(BMFlashCamera) flash {
    if (_captureSession && self.captureDevice) {
        [self.captureSession beginConfiguration];
        if ([self.captureDevice isTorchAvailable]) {
            [self.captureDevice lockForConfiguration:nil];
            [self.captureDevice setTorchMode:(AVCaptureTorchMode)flash];
            [self.captureDevice unlockForConfiguration];
            //duylh2: nho chu y
            _flash = flash;
        }
        [self.captureSession commitConfiguration];
    }
}

- (dispatch_queue_t)queue {
    if (!_queue) {
        _queue = dispatch_queue_create("bm.camera", DISPATCH_QUEUE_SERIAL);
    }
    return _queue;
}

- (CameraCore *)cameraCore {
    if (!_cameraCore) {
        _cameraCore = CameraCore.new;
    }
    return _cameraCore;
}

- (void)async:(BlockOfBackground)blockOfBackground {
    CameraView * __weak weakSelf = self;
    dispatch_async(weakSelf.queue, ^(void){
        if (weakSelf) {
            blockOfBackground(weakSelf);
        } else {
            NSLog(@"CamneraView has been deallocated in the meantime.");
        }
    });
}
- (void) asyncBackground:(BlockOfBackground) blockBackground asyncMain:(BlockOfMain) blockMain{
    CameraView * __weak weakSelf = self;
    dispatch_async(weakSelf.queue, ^(void) {
        if (weakSelf) {
            blockBackground(weakSelf);
        } else {
            NSLog(@"CamneraView has been deallocated in the meantime.");
        }
        dispatch_async(dispatch_get_main_queue(), ^(void){
            blockMain(weakSelf);
        });
    });
    
}

@end
