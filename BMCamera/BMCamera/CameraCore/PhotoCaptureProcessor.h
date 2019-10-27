//
//  PhotoCaptureProcessor.h
//  BMCamera
//
//  Created by Steve on 10/22/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "../CameraEnum/CameraEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoCaptureProcessor : NSObject <AVCapturePhotoCaptureDelegate>
struct photoCaptureOptions {
    BMCamPosition  camPos;
    BMRatioCamera  ratio;
    UIInterfaceOrientation interfaceOrientation ;
    int imageQulity;
    CGPoint origin;
    
};
@property (nonatomic) dispatch_queue_t queue;
@property (nonatomic) int64_t uniqueID;
@property (nonatomic) struct photoCaptureOptions photoCaptureOptions;
typedef void(^willCapturePhotoAnimation)(void);
typedef void(^completeHandler)(PhotoCaptureProcessor *processor, UIImage *img);
@property (nonatomic) willCapturePhotoAnimation  willCapturePhotoAnimation;
@property (nonatomic) completeHandler  completeHandler;
- (instancetype)initWithUniqueID:(int64_t) uniqueID photoCaptureOptions:(struct photoCaptureOptions) options willCapturePhotoAnimation:(willCapturePhotoAnimation)willCapturePhotoAnimation  andCompleteHandler:(completeHandler) completeHandler;

@end

NS_ASSUME_NONNULL_END
