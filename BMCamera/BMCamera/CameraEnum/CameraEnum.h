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

typedef NS_ENUM(NSUInteger, BMTypeCamera) {
    kBMPhoto,
    kBMVideo,
    
};

typedef NS_ENUM(NSUInteger, BMCamPosition) {
    kBMCamPositionBack = AVCaptureDevicePositionBack,
    kBMCamPositionFront = AVCaptureDevicePositionFront,

};


typedef NS_ENUM(NSUInteger, BMRatioCamera) {
    kBMFULL  ,
    kBMSQUARE ,
    kBMTHREE_FOUR,
    kBMCIRCLE
};

typedef NS_ENUM(NSUInteger, BMTorchCamera) {
    kBMTorchOff = 0 ,
    kBMTorchOn = 1
};



typedef NS_ENUM(NSUInteger, BMPosPreview) {
    kBMPreviewTop,
    kBMPreviewCenter,
    kBMPreviewBottom,
};





#endif /* CameraEnum_h */
