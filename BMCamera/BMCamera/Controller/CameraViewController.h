//
//  CameraViewController.h
//  ZBMCamera
//
//  Created by Steve on 10/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../View/CameraView.h"
#import "../CameraEnum/CameraEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface CameraViewController : UIViewController
@property (nonatomic, strong) UIView * bottomView;
@property (nonatomic, strong) UIView * headerView;

@end

NS_ASSUME_NONNULL_END
