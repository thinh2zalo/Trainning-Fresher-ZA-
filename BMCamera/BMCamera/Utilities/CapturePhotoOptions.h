//
//  CapturePhotoOptions.h
//  BMCamera
//
//  Created by Steve on 10/22/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "../CameraEnum/CameraEnum.h"
NS_ASSUME_NONNULL_BEGIN

@interface CapturePhotoOptions : NSObject
struct photoCaptureOptions {
    BMCamPosition  camPos;
    BMRatioCamera  ratio;
    UIInterfaceOrientation interfaceOrientation ;
    int imageQulity;
    CGPoint origin;
    
};

@end

NS_ASSUME_NONNULL_END
