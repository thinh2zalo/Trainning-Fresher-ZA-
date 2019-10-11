//
//  CameraEnum.h
//  BMCamera
//
//  Created by Steve on 10/10/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#ifndef CameraEnum_h
#define CameraEnum_h
#import <AVFoundation/AVFoundation.h>

typedef enum posCam{
    kBMFRONT ,// AVCaptureDevicePostionFront 2,
    kBMBACK // AVCaptureDevicePostionFront 1
} BMPosCam;

typedef NS_ENUM(NSUInteger, BMCamPosition) {
    BMCamPositionFront,
    BMCamPositionBack,
};

typedef enum RatioCamera {
    kBMFULL  ,
    kBMSQUARE ,
    kBMTHREE_FOUR
} BMCameraRatio;

typedef enum FlashCamera {
    kBMFlashOff = 0 ,
    kBMFlashOn = 1
    
} BMFlashCamera;



#endif /* CameraEnum_h */
