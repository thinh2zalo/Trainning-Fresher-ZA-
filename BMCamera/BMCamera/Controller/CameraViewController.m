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
@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self layoutUI];
    [self.cameraView.cameraCore.captureSession startRunning];
    
}

- (void)layoutUI {
    self.bottomView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/7);
    self.frameCameraView.frame = CGRectMake(0, self.bottomView.frame.size.height, self.view.frame.size.width, (self.view.frame.size.height/7) * 5);
    self.frameCameraView.frame = CGRectMake(0, self.bottomView.frame.size.height + self.frameCameraView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/7);
}

- (CameraView *)cameraView {
    if (!_cameraView) {
        _cameraView = CameraView.new;
        [self.frameCameraView addSubview:_cameraView];
    }
    return _cameraView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = UIView.new;
        _bottomView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
    
}

- (UIView *)frameCameraView {
    if (!_frameCameraView) {
        _frameCameraView = UIView.new;
        _frameCameraView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_frameCameraView];
    }
    return _frameCameraView;
    
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = UIView.new;
        _headerView.backgroundColor = [UIColor blackColor];
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
