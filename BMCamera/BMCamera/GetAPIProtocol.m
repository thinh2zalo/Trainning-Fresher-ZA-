//
//  GetAPIProtocal.m
//  BMCamera
//
//  Created by Steve on 10/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "../BMCamera/CameraEnum/CameraEnum.h"
#ifndef DecodeProtocol_h
#define DecodeProtocol_h
@protocol GetAPIProtocol <NSObject>

- (AVCaptureDevice *) getCaptureDeviceWithPostion:(BMCamPosition) position;

@end



#endif /* DecodeProtocol_h */
