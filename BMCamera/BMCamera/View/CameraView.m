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
@property (nonatomic, strong) CameraFocusView * focusView;

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

- (void)layoutSubviews {
//    self.focusView.frame = CGRectMake(20, 20, 70, 70);
}

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

- (void)focusAtThePoint:(CGPoint) atPoint {
    if (self.captureDevice != nil) {
        
        if([self.captureDevice isFocusPointOfInterestSupported] &&
           [self.captureDevice isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            CGRect bounds = [self.layer bounds];
            double cameraViewWidth = bounds.size.width;
            double cameraViewHeight = bounds.size.height;
            double focus_x = atPoint.x/cameraViewWidth;
            double focus_y = atPoint.y/cameraViewHeight;
            CGPoint cameraViewPoint = CGPointMake(focus_x, focus_y);
            if([self.captureDevice lockForConfiguration:nil]) {
                [self.captureDevice setFocusPointOfInterest:cameraViewPoint];
                [self.captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
                if ([self.captureDevice isExposurePointOfInterestSupported] && [self.captureDevice isExposureModeSupported:AVCaptureExposureModeAutoExpose]) {
                    [self.captureDevice setExposureMode:AVCaptureExposureModeAutoExpose];
                    [self.captureDevice setExposurePointOfInterest:cameraViewPoint];
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
    
    if (self.focusView)
    {
        [self.focusView removeFromSuperlayer];
    }
        self.focusView = CameraFocusView.new;
//        self.focusView = [[CameraFocusView alloc]initWithFrame:CGRectMake(touchPoint.x-40, touchPoint.y-40, 80, 80)];
        [self.layer addSublayer:self.focusView];
        [self.focusView setNeedsDisplay];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0];
//        [self.focusView.layer setAlpha:0.0];
        [UIView commitAnimations];
    
}
- (void) startCameraWithPosition:(BMCamPosition) position{

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
        BMTorchCamera on = kBMTorchOn;
        BMTypeCamera type = kBMPhoto;
        [cameraView changeType:type];
        [cameraView updateTorch:on];
        [cameraView changeCameraPosition:cameraView.position];
        [cameraView.captureSession commitConfiguration];
        [cameraView.captureSession startRunning];
    } asyncMain:^(CameraView * cameraView) {
        [cameraView setPosPreview:kBMPreviewCenter];
        BMRatioCamera ratio = kBMSQUARE;
        [cameraView updateRatio:ratio];
    }];
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
            
            }
        }

        self.captureDevice = [self.cameraCore getCurrentCaptureDeviceWithPostion:position];
        
        //handle Error?
        AVCaptureDeviceInput *newDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:nil];
        
        if ([self.captureSession canAddInput:newDeviceInput]) {
            [self.captureSession addInput:newDeviceInput];
            _position = position;
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
    CGRect bounds = self.layer.bounds;
    
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
            yCaseSquare = height - height_1_1 + width / 3 ;
    }
    
    switch (ratio) {
        case kBMSQUARE: frame = CGRectMake(0, yCaseSquare , width, width);

            break;
        case kBMTHREE_FOUR: frame = CGRectMake(0, yCaseThreeFour, width, (width / 3 )* 4);
            break;
        case kBMFULL: frame = bounds;
    }
    _ratio = ratio;
    _captureVideoPreviewLayer.frame = frame;
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
- (CameraFocusView *)focusView {
    if (!_focusView) {
        _focusView = CameraFocusView.new;
        [self addSubview:_focusView];
    }
    return _focusView;
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

@end
