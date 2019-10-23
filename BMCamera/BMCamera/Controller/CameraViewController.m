//
//  CameraViewController.m
//  ZBMCamera
//
//  Created by Steve on 10/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "CameraViewController.h"
#import "../View/CameraView+Execute.m"
@interface CameraViewController ()
@property (nonatomic, strong ) CameraView * cameraView;
@property (nonatomic, strong) UIButton * switchCameraBtn;
@property (nonatomic, strong) UIButton * switchRatioBtn;
@property (nonatomic, strong) UIButton * flashBtn;
@property (nonatomic, strong) UIButton * takePictureButton;

@property (nonatomic, strong) MaskLayer *maskLayer;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self layoutUI];

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BMCamPosition pos = kBMCamPositionBack;
    [self.cameraView startCameraWithPosition:pos];

}


- (void)layoutUI {
    self.cameraView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.cameraView.clipsToBounds = YES;
    
    self.takePhotoButton.frame = CGRectMake(self.view.frame.size.width/2 - 40, self.view.frame.size.height - 80, 80, 80);
    self.switchRatioBtn.frame = CGRectMake(self.view.frame.size.width/2 - 20 , 80/3, 30, 30);
    self.flashBtn.frame = CGRectMake(20, 80/3, 30, 30);
    self.switchCameraBtn.frame = CGRectMake(self.view.frame.size.width - 60, 80/3, 30, 30);
   
    
}

- (void)switchRatio {
    switch (self.cameraView.ratio) {
        case kBMSQUARE:
            [self.cameraView setRatio:kBMFULL];
            break;
        case kBMFULL:
            [self.cameraView setRatio:kBMTHREE_FOUR];

            break;
        case kBMTHREE_FOUR:
            [self.cameraView setRatio:kBMSQUARE]; break;
        default:[self.cameraView setRatio:kBMCIRCLE];
        
    }
}

- (void)switchCamera {
    
    if (self.cameraView.position == kBMCamPositionFront) {
        [self.cameraView setPosition:kBMCamPositionBack];

    } else {
        [self.cameraView setPosition:kBMCamPositionFront];

    }
    
}

- (void)onOffFlash {
    switch (self.cameraView.flash) {
        case kBMTorchOn:
            [self.cameraView setFlash:kBMTorchOff];
            break;
        case kBMTorchOff:
            [self.cameraView setFlash:kBMTorchOn];
  }
}

- (void)takePicture {
    [self.cameraView takePicture];
}

- (UIButton *)takePhotoButton {
    if (!_takePictureButton) {
        _takePictureButton = UIButton.new;
        UIImage *image = [UIImage imageNamed:@"take_photo_icon"];
        [_takePictureButton setImage:image forState:UIControlStateNormal];
        [_takePictureButton addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_takePictureButton];
    }
    return _takePictureButton;
}

- (CameraView *)cameraView {
    if (!_cameraView) {
        _cameraView = CameraView.new;
        [self.view addSubview:_cameraView];
    }
    return _cameraView;
}

- (UIButton *)flashBtn {
    if (!_flashBtn) {
        _flashBtn = UIButton.new;
        [_flashBtn setImage:[UIImage imageNamed:@"ic_cam_flash"] forState:UIControlStateNormal];
        [_flashBtn addTarget:self action:@selector(onOffFlash) forControlEvents:UIControlEventTouchUpInside];
        [_flashBtn setIsAccessibilityElement:true];
        [_flashBtn setAccessibilityIdentifier:@"btn_flash"];
        [_flashBtn setAccessibilityLabel:@"button flash"];
        [self.view addSubview:_flashBtn];
    }
    return _flashBtn;
    
}

- (UIButton *)switchRatioBtn {
    if (!_switchRatioBtn) {
        _switchRatioBtn = UIButton.new;
        [_switchRatioBtn setImage:[UIImage imageNamed:@"ic_cam_ratio_number"] forState:UIControlStateNormal];
        [_switchRatioBtn addTarget:self action:@selector(switchRatio) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_switchRatioBtn];
    }
    return _switchRatioBtn;
    
}

- (UIButton *)switchCameraBtn {
    if (!_switchCameraBtn) {
        _switchCameraBtn = UIButton.new;
        [_switchCameraBtn setImage:[UIImage imageNamed:@"switch"] forState:UIControlStateNormal];
        [_switchCameraBtn addTarget:self action:@selector(switchCamera) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_switchCameraBtn];
    }
    return _switchCameraBtn;
    
}



@end
