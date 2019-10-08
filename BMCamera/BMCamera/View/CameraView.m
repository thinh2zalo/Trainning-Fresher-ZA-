//
//  CameraView.m
//  ZBMCamera
//
//  Created by Steve on 10/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "CameraView.h"

@implementation CameraView


- (CameraCore *)cameraCore {
    if (!_cameraCore) {
        _cameraCore = CameraCore.new;
        
    }
    return _cameraCore;
}
- (void)takePhoto {
    
}

@end
