//
//  CameraView.h
//  ZBMCamera
//
//  Created by Steve on 10/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../CameraCore/CameraCore.h"

NS_ASSUME_NONNULL_BEGIN

@interface CameraView : UIView
@property (nonatomic, strong) CameraCore * cameraCore;

@end

NS_ASSUME_NONNULL_END
