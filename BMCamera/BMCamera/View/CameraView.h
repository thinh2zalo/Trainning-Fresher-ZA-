//
//  CameraView.h
//  ZBMCamera
//
//  Created by Steve on 10/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../CameraCore/CameraCore.h"
#import "../CameraEnum/CameraEnum.h"
#import "../View/HeaderView.h"

NS_ASSUME_NONNULL_BEGIN

//duylh2: Handle thêm CameraConfig -> lưu xuống local

@interface CameraView : UIView

@property (nonatomic) BMCameraRatio ratio;
@property (nonatomic) BMPosCam position;
@property (nonatomic) BMFlashCamera flash;

- (void) startCameraWithPosition:(BMPosCam) position;

@end

NS_ASSUME_NONNULL_END
