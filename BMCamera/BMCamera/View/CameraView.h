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
#import "CameraFocusLayer.h"
#import "MaskLayer.h"

NS_ASSUME_NONNULL_BEGIN

//duylh2: Handle thêm CameraConfig -> lưu xuống local

@interface CameraView : UIView

@property (atomic) BMRatioCamera ratio;
@property (atomic) BMCamPosition position;
@property (atomic) BMTorchCamera flash;
@property (atomic) BMPosPreview posPreview;
@property (assign) BMTypeCamera type;
//@property (nonatomic) setPosOfPreview;

- (void) startCameraWithPosition:(BMCamPosition) position;

@end

NS_ASSUME_NONNULL_END
