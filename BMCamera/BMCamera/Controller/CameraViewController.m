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
@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self layoutUI];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.cameraView startCameraWithPosition:AVCaptureDevicePositionBack];

}

- (void)layoutUI {
    self.headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/7);
    self.cameraView.frame = CGRectMake(0, self.headerView.frame.size.height, self.view.frame.size.width, (self.view.frame.size.height/7) * 5);
    self.bottomView.frame = CGRectMake(0, self.headerView.frame.size.height + self.cameraView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/7);
    self.switchCameraBtn.frame = CGRectMake(self.view.frame.size.width - 50, self.headerView.frame.size.height/3, 40, 40);
}

- (CameraView *)cameraView {
    if (!_cameraView) {
        _cameraView = CameraView.new;
        [self.view addSubview:_cameraView];
    }
    return _cameraView;
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

- (void) switchCamera {
    if ([self.cameraView getCurrentPosition] == AVCaptureDevicePositionBack) {
        [self.cameraView changeCameraPosition:AVCaptureDevicePositionFront];
    } else {
        [self.cameraView changeCameraPosition:AVCaptureDevicePositionBack];

    }
    
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = UIView.new;
        _bottomView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
    
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = UIView.new;
        _headerView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_headerView];
    }
    return _headerView;
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
