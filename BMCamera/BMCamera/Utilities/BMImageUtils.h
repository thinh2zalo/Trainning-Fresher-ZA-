//
//  BMImageUtils.h
//  BMCamera
//
//  Created by Steve on 10/22/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../CameraCore/PhotoCaptureProcessor.h"
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BMImageUtils : NSObject
+ (UIImage *) finalizeUIImage:(CGImageRef )cgImage andOptions:(struct photoCaptureOptions) options;

@end

NS_ASSUME_NONNULL_END
