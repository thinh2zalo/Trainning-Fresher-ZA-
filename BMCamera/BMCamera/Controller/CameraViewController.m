//
//  CameraViewController.m
//  ZBMCamera
//
//  Created by Steve on 10/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "CameraViewController.h"
@interface CameraViewController ()
@property (nonatomic, strong ) CameraView * cameraView;
@property (nonatomic, strong) UIButton * switchCameraBtn;
@property (nonatomic, strong) UIButton * switchRatioBtn;
@property (nonatomic, strong) UIButton * flashBtn;
@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self layoutUI];

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BMCamPosition pos = BMCamPositionBack;
    [self.cameraView startCameraWithPosition:pos];

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)layoutUI {
//    self.headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/7);
    self.cameraView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.cameraView.clipsToBounds = YES;

//    self.bottomView.frame = CGRectMake(0, self.headerView.frame.size.height + self.cameraView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/7);
    self.switchRatioBtn.frame = CGRectMake(self.view.frame.size.width/2 - 13 , 80/3, 30, 30);
    self.flashBtn.frame = CGRectMake(20, 80/3, 30, 30);

    self.switchCameraBtn.frame = CGRectMake(self.view.frame.size.width - 50, 80/3, 30, 30);
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
            [self.cameraView setRatio:kBMSQUARE];
    }
}

- (void) switchCamera {
//    if ([self.cameraView getCurrentPosition] == AVCaptureDevicePositionBack) {
//        [self.cameraView changeCameraPosition:2];
//    } else {
//        [self.cameraView changeCameraPosition:AVCaptureDevicePositionBack];
//
//    }
    
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

- (UIButton *)takePhotoButton {
    if (!_takePhotoButton) {
        _takePhotoButton = UIButton.new;
        UIImage *image = [UIImage imageNamed:@"take_photo_icon"];
        [_takePhotoButton setImage:image forState:UIControlStateNormal];
        [_takePhotoButton addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bottomView addSubview:_takePhotoButton];
    }
    return _takePhotoButton;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
