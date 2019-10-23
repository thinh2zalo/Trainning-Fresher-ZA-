//
//  CameraView.m
//  ZBMCamera
//
//  Created by Steve on 10/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "CameraView.h"
#import "CameraView+Execute.h"


@interface CameraView()

@property (strong, nonatomic) AVCaptureSession * captureSession;

@property (nonatomic, strong) AVCaptureDevice * captureDevice;
@property (nonatomic, weak) AVCaptureVideoPreviewLayer * captureVideoPreviewLayer;
@property (nonatomic, strong) AVCaptureDeviceType deviceType;
@property (nonatomic) dispatch_queue_t queue;
@property (nonatomic, strong) CameraFocusLayer * focusLayer;
@property (nonatomic, strong) MaskLayer *maskLayer;
@property (nonatomic) float lastScale;

typedef void(^BlockOfBackground)(CameraView * cameraView);
typedef void(^BlockOfMain)(CameraView * cameraView);


@end


//Handle error cho moi truong hop

@implementation CameraView
@synthesize position = _position;
@synthesize flash = _flash;
@synthesize ratio = _ratio;
@synthesize type = _type;
@synthesize posPreview = _posPreview;
@synthesize lastScale = _lastScale;




- (void)setupAndStartSession {
    self.captureSession = AVCaptureSession.new;
    [self asyncBackground:^(CameraView * cameraView){
        [cameraView.captureSession beginConfiguration];
        BMTorchCamera on = kBMTorchOn;
        BMTypeCamera type = kBMPhoto;
        [cameraView changeType:type];
        [cameraView updateTorch:on];
        BMCamPosition camPos = kBMCamPositionBack;
        [cameraView changeCameraPosition:camPos];
        [cameraView.captureSession commitConfiguration];
        [cameraView.captureSession startRunning];
        
    } asyncMain:^(CameraView * cameraView) {
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchToZoomRecognizer:)];
        [self addGestureRecognizer:pinchGesture];
        [cameraView setPosPreview:kBMPreviewCenter];
        BMRatioCamera ratio = kBMCIRCLE;
        [cameraView updateRatio:ratio];
    }];
}


- (void)zoom:(CGFloat)zoomFactor{
    if (!_captureVideoPreviewLayer) {
        return;
    }
    
    if ([self.captureDevice lockForConfiguration:nil]) {
        
        self.captureDevice.videoZoomFactor = zoomFactor;
        [self.captureDevice  unlockForConfiguration];
    } else {
        NSLog(@"error");
    }
}

- (void)handlePinchToZoomRecognizer:(UIPinchGestureRecognizer*)pinchRecognizer {
    if (pinchRecognizer.state == UIGestureRecognizerStateBegan) {
        pinchRecognizer.scale = _lastScale;
    }
    CGFloat zoomFactor = MAX(1, MIN(5, pinchRecognizer.scale));
    [self zoom:zoomFactor];
    if (pinchRecognizer.state == UIGestureRecognizerStateEnded) {
        _lastScale = zoomFactor;
    }
}


- (void)focusAtThePoint:(CGPoint) atPoint {
    if (self.captureDevice != nil) {
        
        if([self.captureDevice isFocusPointOfInterestSupported] &&
           [self.captureDevice isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            
            CGRect bounds = [self.layer bounds];
            double cameraViewWidth = bounds.size.width;
            double cameraViewHeight = bounds.size.height;
            double focus_x = atPoint.y/cameraViewHeight;
            double focus_y = (cameraViewWidth - atPoint.x)/cameraViewWidth;
            
            CGPoint cameraViewPoint = CGPointMake(focus_x, focus_y);
            if([self.captureDevice lockForConfiguration:nil]) {
                [self.captureDevice setFocusPointOfInterest:cameraViewPoint];
                [self.captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
                if ([self.captureDevice isExposurePointOfInterestSupported] && [self.captureDevice isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
                    
                    [self.captureDevice setExposurePointOfInterest:cameraViewPoint];
                    [self.captureDevice setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
                }
                [self.captureDevice setSubjectAreaChangeMonitoringEnabled:true];
                [self.captureDevice unlockForConfiguration];
            
            }
        }
        
    }
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // check multi touch
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:touch.view];
    [self focusAtThePoint:touchPoint];
    
    if (self.focusLayer) {
        [self.focusLayer removeFromSuperlayer];
    }
    self.focusLayer = CameraFocusLayer.new;
    self.focusLayer = [[CameraFocusLayer alloc]initWithFrame:CGRectMake(touchPoint.x - 40, touchPoint.y - 40, 80, 80)];
    [self.layer addSublayer:self.focusLayer];
    
}

- (AVCaptureDevicePosition )getCurrentPosition {
    return [self.captureDevice position];
}


- (void)changeCameraPosition:(BMCamPosition) position {
    if (_captureSession) {
        [self.captureSession beginConfiguration];
        for (AVCaptureInput * input in [self.captureSession inputs]) {
            if ([input isKindOfClass:AVCaptureDeviceInput.class] && [[(AVCaptureDeviceInput * )input device] position] != (AVCaptureDevicePosition) position) {
                [self.captureSession removeInput:input];
                NSLog(@"deleted");

            }
        }
        self.captureDevice = [self.cameraCore getCurrentCaptureDeviceWithPostion:position];
        AVCaptureDeviceInput *newDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:nil];

        if ([self.captureSession canAddInput:newDeviceInput]) {
            [self.captureSession addInput:newDeviceInput];
            _position = position;
            NSLog(@"postion in function");
        }

        [self.captureSession commitConfiguration];
    }
}


- (void)changeType:(BMTypeCamera) type {
    if (_captureSession) {
        //duylh2: mising update _type
        [self.captureSession beginConfiguration];
        AVCaptureSessionPreset  preset = AVCaptureSessionPresetHigh;
        
        switch (type) {
            case kBMPhoto:
                preset = AVCaptureSessionPresetPhoto;
                break;
            case kBMVideo:
                preset = AVCaptureSessionPresetHigh;
                // add input audio
                break;
        }
        if ([self.captureSession canSetSessionPreset:preset]) {
            [self.captureSession setSessionPreset:preset];
            _type = type;
        }
        [self.captureSession commitConfiguration];
        
    }
}


- (void)updateRatio:(BMRatioCamera) ratio {
    if (_captureSession) {
        if (!_captureVideoPreviewLayer) {
            _captureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
            _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            [self.layer addSublayer:_captureVideoPreviewLayer];
        }
        [self updateFrameRatio:ratio];
        
    } else NSLog(@"error");
}

- (void)updateFrameRatio:(BMRatioCamera) ratio {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    CGRect frame = bounds;
    float width = bounds.size.width;
    float height = bounds.size.height;
    
    float height_3_4 = (4 * width)/3;
    float height_1_1 = width;
    
    float yCaseThreeFour = 0;
    float yCaseSquare = width / 3;
    
    switch (_posPreview) {
        case kBMPreviewTop:
            yCaseThreeFour = 0;
            yCaseSquare = width / 3;
            break;
        case kBMPreviewCenter:
            yCaseThreeFour = (height - height_3_4) / 2;
            yCaseSquare = (height - height_1_1 ) / 2;
            break;
        case kBMPreviewBottom:
            yCaseThreeFour = height - height_3_4;
            yCaseSquare = yCaseThreeFour ;
    }
    switch (ratio) {
        case kBMTHREE_FOUR: frame = CGRectMake(0, yCaseThreeFour, width, (width / 3 ) * 4);
            break;
        case kBMFULL: frame = bounds;
            break;
        default: frame = CGRectMake(0, yCaseSquare , width, width);
    }

    _ratio = ratio;
    CameraView * __weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        __weakSelf.frame = frame;
        __weakSelf.captureVideoPreviewLayer.frame = self.bounds;
        if (ratio == kBMCIRCLE) {
            self->_maskLayer = [[MaskLayer alloc] initWithFrame:frame];
            [self.layer addSublayer:self->_maskLayer];
        }
    }];
}

- (void)updateTorch:(BMTorchCamera) flash {
    if (_captureSession && self.captureDevice) {
        [self.captureSession beginConfiguration];
        if ([self.captureDevice isTorchAvailable]) {
            [self.captureDevice lockForConfiguration:nil];
            [self.captureDevice setTorchMode:(AVCaptureTorchMode)flash];
            [self.captureDevice unlockForConfiguration];
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
- (CameraFocusLayer *)focusLayer {
    if (!_focusLayer) {
        _focusLayer = CameraFocusLayer.new;
        [self.layer addSublayer:_focusLayer];
    }
    return _focusLayer;
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
            dispatch_async(dispatch_get_main_queue(), ^(void){
                blockMain(weakSelf);
            });
        } else {
            NSLog(@"CamneraView has been deallocated in the meantime.");
        }
    });
    
}



- (void)setType:(BMTypeCamera)type {
    if (type != _type) {
        [self async:^(CameraView * cameraView){
            [cameraView changeType:type];
        }];
    }
}

- (void)setFlash:(BMTorchCamera)flash {
    if (flash != _flash) {
        [self async:^(CameraView * cameraView) {
            [cameraView updateTorch:flash];
        }];
    }
}


- (void)setPosPreview:(BMPosPreview)posPreview {
    if (posPreview != _posPreview) {
        _posPreview = posPreview;
        [self updateRatio:_ratio];
    }
}


- (void)setRatio:(BMRatioCamera)ratio {
    if (ratio != _ratio) {
        [self updateRatio:ratio];
    }
}


- (void)setPosition:(BMCamPosition)position {
    if (position != _position) {
        [self async:^(CameraView * camera){
            [camera changeCameraPosition:position];
        }];
    }
}

- (CGSize)getPreviewSize {
    return CGSizeMake(self.captureVideoPreviewLayer.frame.size.width, self.captureVideoPreviewLayer.frame.size.height);
}

- (BMTypeCamera)type {
    return _type;
}

- (BMPosPreview)posPreview {
    return _posPreview;
}

- (BMTorchCamera)flash{
    return _flash;
}

- (BMRatioCamera)ratio {
    return _ratio;
}

- (BMCamPosition)position {
    return  _position;
}


- (void) stopCamera {
    [self async:^(CameraView *cameraView) {
        [self.captureSession stopRunning];
    }];
}

- (void)startCameraWithPosition:(BMCamPosition) position{
    
    //duylh2: dùng CameraConfig để lưu xuống local
    self.position = position;
    _lastScale = 1;
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

@end
