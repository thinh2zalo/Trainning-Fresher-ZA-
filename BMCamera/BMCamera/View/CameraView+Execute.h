//
//  CameraView+Execute.h
//  BMCamera
//
//  Created by Steve on 10/22/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "CameraView.h"
#import "../CameraCore/CameraCore.h"

NS_ASSUME_NONNULL_BEGIN

@interface CameraView()
@property (strong, nonatomic) AVCaptureOutput * captureOutput;
@property (nonatomic, strong) CameraCore * cameraCore;


@end

NS_ASSUME_NONNULL_END
